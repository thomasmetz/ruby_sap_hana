require 'net/https'

module Hana
  class XSodata
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    attr_accessor :body

    def initialize(path)
      # set to disable certification
      @uri = URI(path)
    end

    def get(param={})
      req = Net::HTTP::Get.new @uri.path
      call_service(req)
    end

    def post(json_body)
      req = Net::HTTP::Post.new @uri.path
      req.body = json_body
      call_service(req)
    end

    private

    def call_service(req)
      set_header(req)

      res = Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do |http|
        http.ssl_version = :SSLv3
        http.use_ssl = true
        http.request req
      end
      return res.body
    end

    def set_header(req)
      req['Content-Type'] = 'application/json'
      req['Accept'] = 'application/json'
    end
  end
end
