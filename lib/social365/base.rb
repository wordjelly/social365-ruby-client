require "byebug"
require "nokogiri"
require "typhoeus"
require "active_support/all"

class Social365::Base
	include Social365::Image
	
	attr_accessor :host

	def initialize(host)
		self.host = host
	end

	
	
end