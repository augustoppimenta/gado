json.array!(@rows) do |row|
  json.extract! row, :id, :user_id, :age, :race_id
  json.url row_url(row, format: :json)
end
