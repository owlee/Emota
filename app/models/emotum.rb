require 'listen'

class Emotum < ActiveRecord::Base
  belongs_to :emotion

  attr_accessor :emotion_client, :sns_client

  @@emotion_client = EmotionClient.new
  @@sns_client = SnsClient.new

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
        puts '1: file is on server'
        puts '2: file is sent to API'

        json = emotum.send_to_api

        puts '3: score is received back from API'

        emotum.parse_score json

        puts '4: scores are now stored in DB'

        @@sns_client.send_score emotum

        puts '5: scores sent to Emota User'
      else
        raise Exception # Something went wrong
      end
    end
    listener.start # not blocking
    sleep
  end

  # !!!!! must check those fields exists, no error check yet.
  def server_to_api_time
    # in secs
    sent_api - on_server
  end

  def api_to_server_time
    # in secs
    received_api - sent_api
  end

  def server_to_db_time
    # in secs
    stored_score - received_api
  end

  def vm_time
    # in secs
    stored_score - sent_api
  end

  def send_to_api
    self.update sent_api: Time.now
    json = @@emotion_client.call(File.read self.path)
    self.update received_api: Time.now
    json
  end

  def parse_score json
    json = JSON.parse json
    if !json.empty?
      #r = json[0]["faceRectangle"]
      sc = json[0]["scores"]

      emotion = Emotion.create sadness: sc["sadness"], neutral: sc["neutral"], contempt: sc["contempt"], disgust: sc["disgust"], anger: sc["anger"], surprise: sc["surprise"], fear: sc["fear"], happiness: sc["happiness"]
    else
      # No data on image will produce 0 response
      emotion = Emotion.create sadness: 0, neutral: 0, contempt: 0, disgust: 0, anger: 0, surprise: 0, fear: 0, happiness: 0
    end
    emotion_id = emotion.id

    update emotion_id: emotion.id
    update stored_score: Time.now
  end
end
