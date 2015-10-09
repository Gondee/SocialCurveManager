json.array!(@users) do |user|
  json.extract! user, :id, :first, :last, :adress, :phone, :url, :note
  json.url user_url(user, format: :json)
end
