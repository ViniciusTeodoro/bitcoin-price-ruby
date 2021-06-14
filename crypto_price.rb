require 'rest-client'
require 'json'
require 'terminal-table'


ticker = (ARGV[0]&& ARGV[0].include?("-c")) ? ARGV[0].split("=")[1] : "BTC"
url = "https://api.coindesk.com/v1/bpi/currentprice/"
params = "#{ticker}.json"

response = RestClient.get "#{url}#{params}", { content_type: :json, accept: :json}

bpi = JSON.parse(response.body)["bpi"]
bpi_keys = bpi.keys

table_data = bpi.map.with_index do |(data), i|
    [
       bpi_keys[i],
       bpi[bpi_keys[i]]["rate"]
    ]
end

table = Terminal::Table.new headings: ['MOEDA', "Valor do bitcoin"], :rows => table_data

puts table
