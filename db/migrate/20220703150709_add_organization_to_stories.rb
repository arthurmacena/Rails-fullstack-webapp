class AddOrganizationToStories < ActiveRecord::Migration[6.1]
  def change
    add_reference :stories, :organization, null: false, foreign_key: true
  end
end
