module Social365::Article

	def get_article(article_id)
		begin
			response = Typhoeus.get(
				  "#{self.host}/articles/#{article_id}.json",
		      headers: {
		      	"Content-Type" => "application/json",
		      	"X-User-Email" => self.email,
				"X-User-Token" => self.auth_token
		      }
			)
			log(response.body,"debug")
			response
		rescue => e
			log(e.message,"error",e)
		end
	end

	def create_article(article)
		begin
			raise "domain id missing" if article["domain_id"].blank?
			raise "title is missing" if article["title"].blank?
			response = Typhoeus.post(
				  "#{self.host}/articles.json",
		      headers: {
		      	"Content-Type" => "application/json",
		      	"X-User-Email" => self.email,
				"X-User-Token" => self.auth_token
		      },
			  body: JSON.generate({
			  	article: article
			  })
			)
			log(response.body,"debug")
			response
		rescue => e
			log(e.message,"error",e)
		end
	end

end
