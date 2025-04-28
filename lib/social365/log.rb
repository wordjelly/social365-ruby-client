module Social365::Log
	def log(message,level="debug",exception=nil)
		puts "message #{message}, level #{level}}"
		unless exception.blank?
			puts "exception : #{exception.backtrace.join("\n")}"
		end
	end
end