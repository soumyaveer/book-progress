class BookProgression < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :book, required: true

  def percent_read
    # formulae: (current_page / total_pages) * 100
    book = Book.find(self.book_id)
    self.current_page > 0 ?  ((self.current_page.to_f / book.pages) * 100).round(2) : 0.0
  end

  def percent_left
    (100.0 - self.percent_read).round(2)
  end
end
