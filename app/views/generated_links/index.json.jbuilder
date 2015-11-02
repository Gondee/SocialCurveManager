json.array!(@generated_links) do |generated_link|
  json.extract! generated_link, :id, :link, :date, :posted, :note
  json.url generated_link_url(generated_link, format: :json)
end
