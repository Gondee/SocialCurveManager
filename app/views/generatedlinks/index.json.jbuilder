json.array!(@generatedlinks) do |generatedlink|
  json.extract! generatedlink, :id, :url, :paidout, :date
  json.url generatedlink_url(generatedlink, format: :json)
end
