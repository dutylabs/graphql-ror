require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    # Check that the factory we created is valid
    expect(build(:user)).to be_valid
  end
  let(:attributes) do
    {
      name: 'Cosmin Rusu',
      email: 'cosmin@dutylabs.ro',
    }
  end

  let(:user) { create(:user, **attributes) }

  describe 'model validations' do
    # check that the title field received the right values
    it { expect(user).to allow_value(attributes[:name]).for(:name) }
    it { expect(user).to allow_value(attributes[:email]).for(:email) }
    # ensure that the name field is never empty
    it { expect(user).to validate_presence_of(:name) }
    # ensure that the email field is never empty
    it { expect(user).to validate_presence_of(:email)}
  end
end
