json.array!(@clearing_houses) do |clearing_house|
  json.extract! clearing_house, :id, :publisher_id, :user_id, :note
  json.url clearing_house_url(clearing_house, format: :json)
end
