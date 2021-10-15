class CreateUserStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stocks do |t|
      t.refrences :user
      t.refrences :stock

      t.timestamps
    end
  end
end
