json.extract! course, :id, :name, :course_number, :instructor, :instructor_username, :library, :semester, :created_at, :updated_at
json.url course_url(course, format: :json)
