class SetNullConstraintOnBooksTitle < ActiveRecord::Migration[5.2]
  def change
    change_column_null :books, :title, false
  end
end
