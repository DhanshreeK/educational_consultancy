class OtpVerification < ApplicationRecord
	    has_one_time_password 
	    after_save :send_otp_code

	    def send_otp_code

    require "rubygems"
    require "net/https"
    require "uri"
    require "json"
     
    apikey = "9skK4vyGX4M-dD8EJMuVkABV4R7nZWoS3Aj8UfLuOM"
    numbers = "#{self.contact_no}"
    message = "your one time password is #{self.otp_code}"
    sender = "TXTLCL"
     
    requested_url = 'https://api.textlocal.in/send/?' + "apikey=" + apikey + "&numbers=" + numbers + "&message=" + URI.escape(message) + "&sender=" + sender
     
    uri = URI.parse(requested_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true 
   http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production request = Net::HTTP::Get.new(uri.request_uri) res = http.request(request)

    request = Net::HTTP::Get.new(uri.request_uri)
     
    res = http.request(request)
    response = JSON.parse(res.body)
    puts (response)

	

 end

end
















