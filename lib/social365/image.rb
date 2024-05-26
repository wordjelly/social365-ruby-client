module Social365::Image
	
	attr_accessor :config
	attr_accessor :frames
	attr_accessor :sections
	attr_accessor :content
	attr_accessor :frame_image_path
	attr_accessor :errors
	attr_accessor :image_base64_string

	CONFIG_MISSING = "CONFIG_MISSING"
	CONTENT_MISSING = "CONTENT_MISSING"
	FRAME_IMAGE_PATH_ERROR = "FRAME_IMAGE_PATH_ERROR"

	## check if server is working.
	def ping
		response = Typhoeus.get("#{self.host}/images/ping")
		if response.code == 200
			return response.body
		end
		return nil
	end

	## @return[Integer] status-code from api.
	## saves accessor :image_base64_string
	## if path is provided, saves image to that path, otherwise stores image in accessor.
	def create_image(path=nil)
		return 0 unless valid?
		response = Typhoeus.post(
			  "#{self.host}/images",
		  body: {
		    config: JSON.generate(self.config),
		    frame_image: File.open(self.frame_image_path)
		  }
		)

		if response.code == 200
			self.image_base64_string = Base64.decode64(response.body)
			if path
				File.open(path, "wb") do |f|
				  f.write(self.image_base64_string)
				end
			end
		end

		return response.code.to_i
	end

	def valid?
		self.errors ||= []
		self.errors << CONFIG_MISSING unless self.config
		self.errors << CONTENT_MISSING unless self.config["content"]
		self.errors << FRAME_IMAGE_PATH_ERROR unless self.frame_image_path
		return self.errors.blank?
	end

	############ CONVENIENCE METHODS ##########


end