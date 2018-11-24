class AddRatingToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :rating, :decimal
  end
end
