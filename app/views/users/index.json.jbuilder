json.array!(@users) do |user|
  json.extract! user, :id, :first, :last, :address, :phone, :url, :note
  json.url user_url(user, format: :json)
end
