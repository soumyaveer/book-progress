class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :book_progressions do |t|
      t.string :title
      t.string :author
      t.integer :pages

      t.timestamps null: false
    end
  end
end
