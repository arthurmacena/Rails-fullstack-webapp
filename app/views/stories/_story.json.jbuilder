json.extract! story, :id, :title, :body, :status, :created_at, :updated_at
json.url story_url(story, format: :json)
