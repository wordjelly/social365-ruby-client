# frozen_string_literal: true

require "test_helper"

class TestSocial365 < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Social365::VERSION
  end

=begin
  def test_signs_in
    client = Social365::Base.new("http://localhost:5000")
    response = client.set_auth_token(ENV["SOCIAL_365_ADMIN_USER"],ENV["SOCIAL_365_ADMIN_PASSWORD"])
    assert_equal true, !client.auth_token.blank?
  end


  def test_creates_article
    client = Social365::Base.new("http://localhost:5000")
    if client.set_auth_token(ENV["SOCIAL_365_ADMIN_USER"],ENV["SOCIAL_365_ADMIN_PASSWORD"])
      article_create_response = client.create_article({
          "domain_id" => 14,
          "title" => "test_article"
        })
      puts JSON.parse(article_create_response.body)
    end
  end
=end
  def test_get_article
    client = Social365::Base.new("http://localhost:5000")
    if client.set_auth_token(ENV["SOCIAL_365_ADMIN_USER"],ENV["SOCIAL_365_ADMIN_PASSWORD"])
      #article_create_response = client.create_article({
      #    "domain_id" => 1,
      #    "title" => "test_article"
      #  })
      #r = JSON.parse(article_create_response.body)
      article_id = 2
      article_get_response = client.get_article(article_id)
      r = JSON.parse(article_get_response.body)
      puts r.to_s
    end
  end

  

=begin
  def test_pings_server
    client = Social365::Base.new("http://localhost:8080")
    assert_equal "pong", client.ping
  end

  def test_sets_image_attr
    client = Social365::Base.new("http://localhost:8080")
    client.config = {
      "content" => [
        {
          "name" => "title",
          "text" => ["Test image"],
          "lines" => [],
          "font" => {
            "size" => 25,
            "min_size" => 20,
            "face" => "RobotoMono",
            "line_height" => 25
          } 
        }
      ]
    }
    client.frame_image_path = File.open("#{Dir.pwd}/resources/favicon.png")
    client.create_image
    assert_equal true, (client.image_base64_string.size > 0)
  end

  def test_saves_image
    client = Social365::Base.new("http://localhost:8080")
    client.config = {
      "content" => [
        {
          "name" => "title",
          "text" => ["Test image"],
          "lines" => [],
          "font" => {
            "size" => 25,
            "min_size" => 20,
            "face" => "RobotoMono",
            "line_height" => 25
          } 
        }
      ]
    }
    client.frame_image_path = File.open("#{Dir.pwd}/resources/favicon.png")
    fname = SecureRandom.uuid
    client.create_image("#{Dir.pwd}/output/#{fname}.png")
    assert_equal true, File.exists("#{Dir.pwd}/output/#{fname}.png")

  end
=end
  
  # lets assume we have a bunch of keywords
  # first we want to segment them into groups and build sections around those groups.
  # and build this outline using that.

=begin
  def test_create_bilirubin_sections
    client = Social365::Base.new("http://localhost:5000")
    if client.set_auth_token(ENV["SOCIAL_365_ADMIN_USER"],ENV["SOCIAL_365_ADMIN_PASSWORD"])
      important_keywords = (IO.read("#{Dir.pwd}/resources/bilirubin_keywords.txt"))
      article_create_response = client.create_article({
          "domain_id" => 1,
          "title" => "Bilirubin level 2.1 : Is it dangerous, causes, symptoms, home remedies",
          "keywords" => "#{important_keywords}"
        })
      puts JSON.parse(article_create_response.body)
    end
  end
=end
end
