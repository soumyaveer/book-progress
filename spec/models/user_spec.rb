describe User do
  describe 'validations' do
    let (:user) do
      User.new(username: "Harry Potter",
               email: "harry_potter@hogwarts.edu",
               password: "harry1")
    end

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
  end
end
