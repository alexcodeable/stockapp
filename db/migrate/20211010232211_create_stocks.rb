class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company
      t.decimal :last_price

      t.timestamps
    end
  end
end
