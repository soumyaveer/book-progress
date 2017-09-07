describe Book do
  describe 'validations' do
    let(:book) do
      Book.new(title: "Fantastic Beasts and Where to Find Them.",
               author: "Newt Scamander",
               pages: 500)
    end

    it 'fails if book has no title' do
      book.title = nil

      expect(book.valid?).to eql(false)
      expect(book.errors[:title]).to be_present
    end

    it 'fails if book has no pages' do
      book.pages = nil

      expect(book.valid?).to eql(false)
      expect(book.errors[:pages]).to be_present
    end

    it 'fails if number of pages in the book is not a numeric value' do
      book.pages = "five hundred"

      expect(book.valid?).to eql(false)
      expect(book.errors[:pages]).to be_present
    end

    it 'passes even if author of the book is not present' do
      book.author = nil

      expect(book.valid?).to eql(true)
    end

    it 'passes when all the attributes are present' do
      expect(book.valid?).to eql(true)
    end
  end

  describe 'order_by_created_at' do
    before do
      @book1 = Book.create(title: "Fantastic Beasts and Where to Find Them.",
                          author: "Newt Scamander",
                          pages: 500,
                          created_at: 2.days.ago)

      @book2 = Book.create(title: "A History of Magic",
                          author: "Bathilda Bagshot",
                          pages: 1000,
                          created_at: 1.day.ago)
    end

    it 'returns the books in the descending order of creation' do
      expect(Book.order_by_created_at).to match_array([@book2, @book1])
    end
  end
end
