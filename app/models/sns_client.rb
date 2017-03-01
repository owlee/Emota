class SnsClient
  attr_accessor :sns, :json, :subscriber_file

  # --- USAGE --
  # sns.operation_names
  #c = SnsClient.new
  #c.send
  def initialize params = {}
    @subscriber_file = YAML.load_file("#{Rails.application.root}/db/subscribers.yml")

    @sns = Aws::SNS::Client.new(
      region: "us-east-1",
      access_key_id: Rails.application.secrets.SNS_ACCESS_KEY_ID,
      secret_access_key: Rails.application.secrets.SNS_SECRET_ACCESS_KEY)
  end

  def send message = nil
    if !@subscriber_file.empty?
      subscriber_file.each do |subscriber|
        message ||= "Hello, #{subscriber["subscriber"]["first_name"]} #{subscriber["subscriber"]["last_name"]}"

        phone_number = subscriber["subscriber"]["phone_number"].to_s
        @sns.publish(phone_number: phone_number, message: message)
      end
    else
      # Rescue No subscribers yet. TODO: rescue
    end
  end

  def send_score emotum
    emotum.class == Emotum
    send(self.stringify emotum)
  end

  # TODO: sendEmota and to_str should do same thing and call with message
  # def sendEmota
  #   begin
  #     r = @json[0]["faceRectangle"]
  #     sc = @json[0]["scores"]
  #     faceRectangle = "Face Rectangle:\n Width: #{r["width"]}, Height: #{r["height"]}, top: #{r["top"]}, left: #{r["left"]}\n"
  #     score = "Score: \n sadness: #{sc["sadness"]}, neutral: #{sc["neutral"]}, contempt: #{sc["contempt"]}, disgust: #{sc["disgust"]}, anger: #{sc["anger"]}, surprise: #{sc["surprise"]}, fear: #{sc["fear"]}, happiness: #{sc["happiness"]}"
  #     send (faceRectangle + score)
  #   rescue EmptyJsonError
  #     $stderr.print "JSON response is empty: " + $!
  #     raise
  #   end
  # end

  def stringify emotum
    emotum.class == Emotum
    score = "----- Score ----- \n
      sadness: #{emotum.emotion.sadness}\nneutral: #{emotum.emotion.neutral}\ncontempt: #{emotum.emotion.contempt}\n
                                              disgust: #{emotum.emotion.disgust}\nanger: #{emotum.emotion.anger}\nsurprise: #{emotum.emotion.surprise}\n
                                              fear: #{emotum.emotion.fear}\nhappiness: #{emotum.emotion.happiness}"
    score
  end
end
