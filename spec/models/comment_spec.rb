require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  context "Migrations" do
    it { is_expected.to have_db_column(:body).of_type(:text) }

    include_examples "Timestamps presence"
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:body) }
  end
end
