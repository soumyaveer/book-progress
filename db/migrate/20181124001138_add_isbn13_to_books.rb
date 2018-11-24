class AddIsbn13ToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :ISBN_13, :text, null: false
  end
end
