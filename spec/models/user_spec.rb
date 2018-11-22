describe User do
  describe 'validations' do
    let(:user) { User.new(user_attributes) }

    it 'fails validation if username is not present' do
      user.username = nil

      expect(user.valid?).to eql(false)
      expect(user.errors[:username]).to be_present
    end

    it 'fails validation if email is not present' do
      user.email = nil

      expect(user.valid?).to eql(false)
      expect(user.errors[:email]).to be_present
    end

    it 'fails validation if password is not present' do
      user.password = nil

      expect(user.valid?).to eql(false)
      expect(user.errors[:password]).to be_present
    end

    it 'fails validation if email does not look like email' do
      user.email = "test@"

      expect(user.valid?).to eql(false)
      expect(user.errors[:email]).to be_present
    end

    it 'passes validation if all the required attributes are present' do
      expect(user.valid?).to eql(true)
    end
  end
end
