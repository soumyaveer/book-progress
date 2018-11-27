class AddDefaultForCurrentPageToBookProgression < ActiveRecord::Migration[5.2]
  def change
    change_column_default :book_progressions, :current_page, default: 0
  end
end
