class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :timeoutable, :trackable, 
         :omniauthable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
    
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[ create update ]

  def avatar_thumbnail
    if avatar.attached?
    avatar.variant(resize: "150x150!").processed
    else
      "/default_avatar.jpg"
    end
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name 
  "Anonymous"
  end


  def stock_already_tracked?(stock_symbol)
    stock = Stock.check_db(stock_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def stock_limit?
    stocks.count < 10
  end

  def track_stock?(stock_symbol)
    stock_limit? && !stock_already_tracked?(stock_symbol)
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.last_name = auth.info.last_name   # assuming the user model has a name
      user.last_name = auth.info.first_name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join( 'app', 'assets', 'images', 'default_avatar.jpg')
        ), filename: 'default_avatar.jpg', content_type: 'image/jpg'
      )
    end
  end
        
end
