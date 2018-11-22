describe Book do
  describe 'validations' do
    let(:book) { Book.new(book_attributes) }

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
end
