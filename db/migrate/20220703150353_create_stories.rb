class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.integer :status, default: 0
      t.references :writer
      t.references :reviewer

      t.timestamps
    end
  end
end
