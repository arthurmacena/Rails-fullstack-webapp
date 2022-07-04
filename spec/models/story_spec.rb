require 'rails_helper'

RSpec.describe Story, type: :model do
  it "has a valid factory" do
    expect(build(:story)).to be_valid
  end

  context "Migrations" do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime) }

    include_examples "Timestamps presence"
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:title) }
  end

  context "status_changes_on_update_story test" do
    before(:each) do
      @story_unassigned = FactoryBot.create(:story, status: 'unassigned')
      @story_pending = FactoryBot.create(:story, status: 'pending')
      @story_archived = FactoryBot.build(:story, status: 'archived')
    end

    it 'when story unassigned' do
      writer = FactoryBot.create(:writer_user, organization: @story_unassigned.organization)
      reviewer = FactoryBot.create(:writer_user, organization: @story_unassigned.organization)
      @story_unassigned.update(writer: writer, reviewer: reviewer)
      expect(@story_unassigned.status_name).to eq('Draft')
    end

    it 'when story pending' do
      @story_pending.content.body = "some text"
      @story_pending.save
      expect(@story_pending.status_name).to eq('Draft')
    end

    it 'when story archived' do
      @story_archived.save
      expect(@story_archived.status_name).to eq('Archived')
      expect(@story_archived.discarded_at).not_to eq(nil)
    end
  end
end
