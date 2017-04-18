require 'net/http'

class EmotionClient
  attr_accessor :request, :uri

  def initialize params = {}
    @uri = URI('https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize')
    @uri.query = URI.encode_www_form({
    })
    @request = Net::HTTP::Post.new(uri.request_uri)
    @request.content_type = 'application/octet-stream'
    #request['Content-Type'] = 'application/json'
    @request['Ocp-Apim-Subscription-Key'] = Rails.application.secrets.MICROSOFT_EMOTION_API_KEY
  end

  def self.retry response
    case response.code
    when "200"
      if response.body.empty?
        puts 'NOTE: no face detected'
        response.body
      else
        response.body
      end
    when "400"
      puts '400 error incorrect read'
    when "401"
      # invalid subscription key
      puts response.message
    when "403"
      # out of call volume
      puts response.message
    when "429"
      # Rate limit is exceeded
      #
    when "500"
      # internal error with API
      puts 'Something went wrong contacting the API'
    else
      # Worse case
      puts 'Errors outside of exceptions'
    end
    response.code
  end

  def call imageBinary
    begin
      @request.body = File.read imageBinary
      output = nil
      loop do
        response = Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do |http|
          http.request(request)
        end
        output = response.body
        break if EmotionClient.retry(response) == "200"
        sleep(3)
      end
      output
    rescue Exception => e
      puts "#{e.to_s}"
      return nil
    end
  end
end
