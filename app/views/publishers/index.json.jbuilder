json.array!(@publishers) do |publisher|
  json.extract! publisher, :id, :first, :last, :address, :phone, :company, :position, :note
  json.url publisher_url(publisher, format: :json)
end
