require 'net/https'
require 'json'
require 'openssl'
require 'date'

# set to disable certification
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
uri = URI('https://IP:PORT/FILE_NAME.xsodata/FILE_NAME')
req = Net::HTTP::Post.new uri.path

id_time = Time.now.to_i
data_now = DateTime.now.strftime('%Q')

req.body='{
            "id":'+id_time.to_s+',
            "agreement_id":"123",
            "order_id":"564575686789",
            "address_source":"ADDRESS",
            "address_target":"ADDRESS",
            "lat_address_source":"-29.6843729",
            "lon_address_source":"-51.0438139",
            "lat_address_target":"-23.6369921",
            "lon_address_target":"-46.7550026",
            "invoice_price":"1231231",
            "price":"223332.0",
            "company_id":"2",
            "shipping_company_id":"2",
            "saving":"0.0",
            "status":"closed",
            "date_source":"/Date('+data_now+')/",
            "date_target":"/Date('+data_now+')/",
            "vehicle_plate":"09876",
            "driver_name":"JOHN"
            }'

puts req.body

req['Content-Type'] = 'application/json;odata=verbose;'
req['Accept'] = 'application/json'
req['content-type'] = 'application/json;charset=utf-8'

res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  #http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  http.ssl_version = :SSLv3
  http.use_ssl = true
  http.request req
end

puts res.body
