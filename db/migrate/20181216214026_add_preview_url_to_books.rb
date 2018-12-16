class AddPreviewUrlToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :preview_url, :text, null: false
  end
end
