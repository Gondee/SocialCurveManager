json.array!(@paymentgroups) do |paymentgroup|
  json.extract! paymentgroup, :id, :transaction_id, :generatedlink_id, :note
  json.url paymentgroup_url(paymentgroup, format: :json)
end
