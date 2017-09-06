class CreateBookProgressions < ActiveRecord::Migration[5.1]
  def change
    create_table :book_progressions do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :current_page

      t.timestamps null: false
    end
  end
end
