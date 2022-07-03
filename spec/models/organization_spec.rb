require "rails_helper"

RSpec.describe Organization, type: :model do
  it "has a valid factory" do
    expect(build(:organization)).to be_valid
  end

  context "Migrations" do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:slug).of_type(:string) }

    include_examples "Timestamps presence"
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
  end

  context "FriendlyId slug tests" do
    before(:each) do
      @organization1 = FactoryBot.create(:organization, name: "BigNameForAOrganization")
      @organization2 = FactoryBot.build(:organization, name: @organization1.name)
    end

    it 'normalize_friendly_id maximum 8 characters without conflict slug' do
      expect(@organization1.normalize_friendly_id("BigNameForAOrganization").length).to eq(8)
      expect(@organization1.normalize_friendly_id("BigNameForAOrganization")).to eq(@organization1.slug)
    end

    it 'generate new random text when have same slug' do
      @organization2.save!
      expect(@organization2.slug).not_to eq(@organization1.slug)
    end

    it 'slug change when organization updates' do
      old_slug = @organization2.slug
      @organization2.update(name: "NewName")
      expect(@organization2.slug).not_to eq(old_slug)
    end
  end
end