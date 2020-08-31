require 'csv'

CSV.foreach(Rails.root.join('public/MOCK_BIZ_DATA.csv').to_s, headers: true) do |row|
  Business.create(row.to_h)
end
