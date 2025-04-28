require "byebug"
require "nokogiri"
require "typhoeus"
require "active_support/all"

class Social365::Base
	include Social365::Image
	include Social365::Article
	include Social365::Log
	
	attr_accessor :host
	attr_accessor :auth_token
	attr_accessor :email

	
	def initialize(host,email=nil,auth_token=nil)
		self.host = host
		self.auth_token = auth_token
		self.email = email
	end

	def sign_in(email,password)
		self.email = email
		response = Typhoeus.post(
			  "#{self.host}/users/sign_in.json",
	      headers: {
	      	"Content-Type" => "application/json"
	      },
		  body: JSON.generate({
		  	user: {
		    	email: email,
		    	password: password
			}
		  })
		)
		if response.code.to_s != "200"
			log(response.body.to_s)
		end
		response
	end

	def set_auth_token(email,password)
		response = sign_in(email,password)
		if response.code.to_s == "200"
			resp = JSON.parse(response.body)
			if resp["auth_token"]
				self.auth_token = resp["auth_token"]
				return true
			end
		end
		return false
	end

	
	
end