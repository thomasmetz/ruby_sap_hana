# ruby_sap_hana
Simple ruby client to connect with xsodata service SAP Hana

If you want to test this client you could use the example above:

body='{json_body }'
hana = Hana::XSodata.new('https://ip_address:port/service_name.xsodata/service_name')
puts hana.post(body)
