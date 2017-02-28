require 'aws-sdk'
require 'yaml'
require 'pry'

class SnsClient
  attr_accessor :sns, :json, :subscriber_file

  def initialize params = {}
    @subscriber_file = YAML.load_file('./subscribers.yml')

    if ARGV[0]
      file = File.read ARGV[0]
      @json = JSON.parse file
    end

    @sns = Aws::SNS::Client.new(
      region: "us-east-1",
      access_key_id: Rails.application.secrets.SNS_ACCESS_KEY_ID,
      secret_access_key: Rails.application.secrets.SNS_SECRET_ACCESS_KEY)
  end

  def send message = ""
    hasMessage = message.empty? ? false : true

    if !@subscriber_file.empty?
      subscriber_file.each do |subscriber|
        message = "Hello, #{subscriber["subscriber"]["first_name"]} #{subscriber["subscriber"]["last_name"]}" if !hasMessage

        phone_number = subscriber["subscriber"]["phone_number"].to_s
        @sns.publish(phone_number: phone_number, message: message)
        puts message
        puts phone_number
        puts "Success!"
      end
    else
      puts 'No subscribers in the subscribers.yml file'
    end
  end

  def sendEmota
    def sendEmota
      begin
        r = @json[0]["faceRectangle"]
        sc = @json[0]["scores"]
        faceRectangle = "Face Rectangle:\n Width: #{r["width"]}, Height: #{r["height"]}, top: #{r["top"]}, left: #{r["left"]}\n"
        score = "Score: \n sadness: #{sc["sadness"]}, neutral: #{sc["neutral"]}, contempt: #{sc["contempt"]}, disgust: #{sc["disgust"]}, anger: #{sc["anger"]}, surprise: #{sc["surprise"]}, fear: #{sc["fear"]}, happiness: #{sc["happiness"]}"
        send (faceRectangle + score)
      rescue EmptyJsonError
        $stderr.print "JSON response is empty: " + $!
        raise
      end
    end

    def parseEmotion
      begin
        #Do some emotion parsing

      rescue EmptyResponseError
        $stderr.print "JSON response is empty: " + $!
        raise
      end
    end

  end
# --- USAGE --
  # sns.operation_names
  #c = SnsClient.new
  #c.sendEmota
