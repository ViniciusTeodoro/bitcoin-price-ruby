require 'rest-client'
require 'json'
require 'terminal-table'

url = "https://api.coindesk.com/v1/bpi/currentprice.json"

response = RestClient.get "#{url}", { content_type: :json, accept: :json}

bpi = JSON.parse(response.body)["bpi"]
bpi_keys = bpi.keys

table_data = bpi.map.with_index do |(data), i|
    [
       bpi_keys[i],
       bpi[bpi_keys[i]]["rate"]
    ]
end

table = Terminal::Table.new headings: ['MOEDA', "Valor"], :rows => table_data

puts table
