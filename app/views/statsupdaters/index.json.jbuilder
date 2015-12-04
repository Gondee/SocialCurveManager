json.array!(@statsupdaters) do |statsupdater|
  json.extract! statsupdater, :id, :name, :interval
  json.url statsupdater_url(statsupdater, format: :json)
end
