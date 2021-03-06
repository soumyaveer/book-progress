class BookProgression < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :book, required: true

  validates :current_page, presence: true, numericality: true

  def as_json
    super(
      only: [
        :book_id,
        :current_page,
        :id,
        :user_id
      ],

      include: [
        book: {
          only: [
            :authors,
            :cover_url,
            :id,
            :pages,
            :preview_url,
            :rating,
            :title
          ]
        }
      ],

      methods: [
        :percent_read
      ]
    )
  end

  def percent_read
    # formulae: (current_page / total_pages) * 100
    book = Book.find_by(id: self.book_id)
    return nil unless book

    self.current_page > 0 ? ((self.current_page.to_f / book.pages) * 100).round(2) : 0.0
  end

  def percent_left
    (100.0 - self.percent_read).round(2)
  end
end
