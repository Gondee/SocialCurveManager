json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :expense, :user_id, :amount, :note
  json.url transaction_url(transaction, format: :json)
end
