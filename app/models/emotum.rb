require 'listen'
require 'net/http'

class Emotum < ActiveRecord::Base
  def self.listen
    listener = Listen.to('bin_emota') do |modified, added, removed|
      #ignore those ^.jpg in the future
      if !modified.empty? || !added.empty?
        fileName ||= added.first
        fileName ||= modified.first
        emotum = Emotum.create(path: fileName, on_server: Time.now)
        puts 'Created an entry.................................'
        puts "Emotum count: #{Emotum.count}"
        puts "Create: #{emotum.path} at: #{emotum.on_server}"
        puts 'Sending to API'
        emotum.send_to_api
      else
        raise Exception # Something went wrong
      end
    end
    listener.start # not blocking
    sleep
  end

  def send_to_api
    uri = URI('https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize')
    uri.query = URI.encode_www_form({
    })

    binary = File.read path

    request = Net::HTTP::Post.new(uri.request_uri)
    request.content_type = 'application/octet-stream'
    #request['Content-Type'] = 'application/json'

    request['Ocp-Apim-Subscription-Key'] = Rails.application.secrets.MICROSOFT_EMOTION_API_KEY
    request.body = binary

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    binding.pry
    case response.code
    when "200"
      if response.body.empty?
        puts 'no face detected'
      else
        parse_score response.body
      end
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
  end

  private

  def parse_score json
    binding.pry
    json = JSON.parse json
    begin
      r = json[0]["faceRectangle"]
      sc = json[0]["scores"]
      faceRectangle = "Face Rectangle:\n Width: #{r["width"]}, Height: #{r["height"]}, top: #{r["top"]}, left: #{r["left"]}\n"
      score = "Score: \n sadness: #{sc["sadness"]}, neutral: #{sc["neutral"]}, contempt: #{sc["contempt"]}, disgust: #{sc["disgust"]}, anger: #{sc["anger"]}, surprise: #{sc["surprise"]}, fear: #{sc["fear"]}, happiness: #{sc["happiness"]}"
      send (faceRectangle + score)
    rescue EmptyJsonError
      $stderr.print "JSON response is empty: " + $!
      raise
    end
  end
end
