class AddDobToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :birthday, :string
    add_column :users, :gender, :string
  end
end
