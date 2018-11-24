class AddIsbn13ToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :isbn_13, :text, null: false
  end
end
