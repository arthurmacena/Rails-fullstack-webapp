require "rails_helper"
RSpec.describe StoriesController, type: :controller do
  let!(:organization)                 { create(:organization, name: "Loja") }
  let!(:chief_user)                   { create(:chief_editor_user, organization: organization) }
  let!(:writer_user)                  { create(:writer_user, organization: organization) }
  let!(:reviewer_user)                { create(:writer_user, organization: organization) }
  # This should return the minimal set of attributes required to create a valid
  # Story. As you add validations to Story, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:story, title: "New-Story", organization: organization, writer: writer_user, reviewer: reviewer_user)
  end

  let(:invalid_attributes) do
    attributes_for(:story, title: "")
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StoriesController. Be sure to keep this updated too.
  context "when user is authorized" do
    before(:each) do
      sign_in chief_user
    end
    describe "GET #index" do
      it "returns a success response" do
        Story.create! valid_attributes
        get :index, params: {}
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {}
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        story = Story.create! valid_attributes
        get :edit, params: { id: story.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Story" do
          expect do
            post :create, params: { story: valid_attributes }
          end.to change(Story, :count).by(1)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { story: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) do
          { title: "New title" }
        end

        it "updates the requested story" do
          story = Story.create! valid_attributes
          put :update, params: { id: story.to_param, story: new_attributes }
          story.reload
          expect(story.title).to eq(new_attributes[:title])
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          story = Story.create! valid_attributes
          put :update, params: { id: story.to_param, story: invalid_attributes }
          expect(response).not_to be_successful
        end
      end
    end
  end
end
