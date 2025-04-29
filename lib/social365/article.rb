module Social365::Article

	# create article -> write id, and build_requested_at
	# get article -> is it review_requested_at => add to review folder.
	# any article that is in review folder, but whose review_requested_at is gone -> send for update
	# store output in articles folder.
	# so which articles to check ?
	# articles where build_requested at is there.
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

	def update_article(article)
		begin
			raise "domain id missing" if article["domain_id"].blank?
			raise "title is missing" if article["title"].blank?
			raise "id is missing" if article["id"].blank?

			response = Typhoeus.put(
				  "#{self.host}/articles/#{article['id']}.json",
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

	################# CONVENIENCE METHODS TO MAKE TI EASY TO CREATE ARTICLES #########

	def create_from_keywords_file(domain_id, title, keywords_file_path,output_directory)
		
		article = {
			"domain_id" => domain_id,
			"title" => title,
			"keywords" => IO.read(keywords_file_path)
		}
		article_create_response = create_article(article)
		article_content = JSON.parse(article_create_response.body)
		if article_content["build_requested_at"]
			if output_directory
				fpath = output_directory + "/#{title.gsub(/\s/,'-')}.json" 
				IO.write(fpath, JSON.pretty_generate(article_content))
			end
		end
		article_create_response
	end

	def get_and_resave_locally(article_json_file_path)
		if article_id = JSON.parse(IO.read(article_json_file_path))["id"]
			response = get_article(article_id)
			IO.write(article_json_file_path, JSON.pretty_generate(JSON.parse(response.body)))
		end
	end

	def update_article_from_file(article_json_file_path)
		article_content = JSON.parse(IO.read(article_json_file_path))
		response = update_article(article_content)
		IO.write(article_json_file_path, JSON.pretty_generate(JSON.parse(response.body)))
	end


end
