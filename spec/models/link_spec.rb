require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'has a valid factory' do
    # Check that the factory we created is valid
    expect(build(:link)).to be_valid
  end
  let(:attributes) do
    {
      url: 'https://example.com',
      description: 'Example url'
    }
  end

  let(:link) { create(:link, **attributes) }

  describe 'model validations' do
    # check that the title field received the right values
    it { expect(link).to allow_value(attributes[:url]).for(:url) }
    it { expect(link).to allow_value(attributes[:description]).for(:description) }
    # ensure that the title field is never empty
    it { expect(link).to validate_presence_of(:url) }
    # ensure that the description field is never empty
    it { expect(link).to validate_presence_of(:description) }
  end
end
