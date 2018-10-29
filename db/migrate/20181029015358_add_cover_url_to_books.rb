class AddCoverUrlToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :cover_url, :text, null: false
  end
end
