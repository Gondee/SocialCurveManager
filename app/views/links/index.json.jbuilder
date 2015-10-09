json.array!(@links) do |link|
  json.extract! link, :id, :url, :date, :used
  json.url link_url(link, format: :json)
end
