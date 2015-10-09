json.array!(@publishers) do |publisher|
  json.extract! publisher, :id, :first, :last, :adresss, :phone, :company, :position, :note
  json.url publisher_url(publisher, format: :json)
end
