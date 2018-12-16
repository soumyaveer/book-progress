class SetUniqueConstraintOnBooksIsbn13 < ActiveRecord::Migration[5.2]
  def change
    add_index :books, :isbn_13, unique: true
  end
end
