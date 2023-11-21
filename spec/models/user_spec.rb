RSpec.describe User, type: :model do
  describe 'Validations' do
    let!(:user) do
      described_class.new(
        email: 'test@test.com',
        first_name: 'First',
        last_name: 'Last',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    context 'when all fields are valid' do
      it 'is valid with valid attributes' do
        expect(user).to be_valid
      end
    end

    context 'when password and password_confirmation do not match' do
      it 'is invalid if password confirmation does not match password' do
        user.password_confirmation = 'different_password'
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end

    context 'when email, first name, and last name are missing' do
      it 'is invalid without an email' do
        user.email = nil
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'is invalid without a first name' do
        user.first_name = nil
        expect(user).not_to be_valid
        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it 'is invalid without a last name' do
        user.last_name = nil
        expect(user).not_to be_valid
        expect(user.errors[:last_name]).to include("can't be blank")
      end
    end

    describe 'Email uniqueness (case insensitive)' do
      it 'ensures email uniqueness (case insensitive)' do
        user = User.create(email: 'TEST@TEST.com', first_name: 'First', last_name: 'Last', password: 'password', password_confirmation: 'password')
        duplicate_user = User.new(email: 'test@test.com', first_name: 'First', last_name: 'Last', password: 'password', password_confirmation: 'password')
        duplicate_user.valid?
        expect(duplicate_user.errors[:email]).to include('has already been taken')
      end
    end

    context 'when password is too short' do
      it 'is invalid if password is less than 6 characters' do
        user.password = '12345'
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) do
      described_class.create(
        email: 'test@test.com',
        first_name: 'First',
        last_name: 'Last',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    context 'when valid credentials are provided' do
      it 'authenticates the user' do
        authenticated_user = described_class.authenticate_with_credentials('test@test.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when invalid email is provided' do
      it 'returns nil for non-existent email' do
        authenticated_user = described_class.authenticate_with_credentials('fake@email.com', 'password')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when invalid password is provided' do
      it 'returns nil for incorrect password' do
        authenticated_user = described_class.authenticate_with_credentials('test@test.com', 'wrong_password')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when mixed case email is provided' do
      it 'authenticates despite case differences in email' do
        authenticated_user = described_class.authenticate_with_credentials('TEST@TEST.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when email contains extra spaces' do
      it 'authenticates disregarding spaces in email' do
        authenticated_user = described_class.authenticate_with_credentials('  test@test.com  ', 'password')
        expect(authenticated_user).to eq(user)
      end
    end
  end
end