class AddForeignKeyConstraints < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :book_progressions, :books
    add_foreign_key :book_progressions, :users
  end
end
