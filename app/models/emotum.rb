require 'listen'

class Emotum < ActiveRecord::Base
  belongs_to :emotion
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", processed: {}}, processors: [:thumbnail, :autogamma]

  attr_accessor :emotion_client, :sns_client, :path

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  @@emotion_client = EmotionClient.new
  @@sns_client = SnsClient.new
  @@count = nil

  def self.build image_file, send_flag, debug_flag
    convo = Emotum.ended_conversation? ? (Conversation.create start_date: Time.now, end_date: Time.now) : Conversation.last

    puts '1: Image is on server.' if debug_flag == 1
    start_time = Time.now
    emotum = Emotum.new avatar: File.new(image_file, "r")
    end_time = Time.now
    emotum.update image_processing_time: end_time - start_time
    puts '2: Image is now processed.' if debug_flag == 1

    puts '3: Starting roundtrip to API.' if debug_flag == 1
    start_time = Time.now
    json_original = emotum.send_to_api File.expand_path(emotum.avatar.path)
    end_time = Time.now
    emotum.update api_roundtrip_time: end_time - start_time

    json_processed = emotum.send_to_api File.expand_path(emotum.avatar.path(:processed))

    puts '4: Updating database/parsing scores' if debug_flag == 1
    start_time = Time.now
    emotum.parse_score json_original         # TODO: currently has an atomic order...it shouldnt
    emotum.update_processed_score json_processed
    end_time = Time.now
    emotum.update score_logging_time: end_time - start_time

    puts '5: Saving Emotum' if debug_flag == 1
    emotum.save!

    if send_flag == 1
      if @@count.nil?
        puts '6: Sending to subscribers' if debug_flag == 1
        @@sns_client.send_score emotum
        @@count = 0
      elsif @@count >= 10
        puts '6: Sending to subscribers' if debug_flag == 1
        @@sns_client.send_score emotum
        @@count = 0
      else
        @@count += 1
      end
    end

    puts '6: Done!' if debug_flag == 1
    convo.update end_date: Time.now
    convo.end_date = Time.now
    convo.save!
    emotum
  end

  def self.listen
    listener = Listen.to('testPat') do |modified, added, removed|
    begin
      #ignore those ^.jpg in the future
      if !modified.empty? || !added.empty?
        fileName ||= added.first
        fileName ||= modified.first

        emotum = Emotum.build fileName, 0, 0

        puts 'Created an entry.................................'
        puts "Emotum count: #{Emotum.count}"
      else
        raise Exception # Something went wrong
      end
    rescue
      retry
    end
    end
    listener.start # not blocking
    sleep
  end

  def self.ended_conversation? wait_time = 1 # minutes
    if Emotum.count == 0
      true
    else
      (Time.now - Emotum.last.created_at)/60 > wait_time
    end
  end

  def send_to_api filepath; json = @@emotion_client.call filepath end

  def parse_score json
    json = JSON.parse json
    if !json.empty?
      #r = json[0]["faceRectangle"]
      sc = json[0]["scores"]

      emotion = Emotion.create sadness: sc["sadness"], neutral: sc["neutral"], contempt: sc["contempt"], disgust: sc["disgust"], anger: sc["anger"], surprise: sc["surprise"], fear: sc["fear"], happiness: sc["happiness"]
    else
      # No data on image will produce 0 response
      emotion = Emotion.create
    end
    emotion_id = emotion.id

    update emotion_id: emotion.id
  end

  def update_processed_score json
    json = JSON.parse json
    if !json.empty?
      sc = json[0]["scores"]
      emotion.update sadness_p: sc["sadness"]
      emotion.update neutral_p: sc["neutral"]
      emotion.update contempt_p: sc["contempt"]
      emotion.update disgust_p: sc["disgust"]
      emotion.update anger_p: sc["anger"]
      emotion.update surprise_p: sc["surprise"]
      emotion.update fear_p: sc["fear"]
      emotion.update happiness_p: sc["happiness"]
    end
  end

  def self.detected_faces_in_original
    faces = []
    Emotum.all.each { |emotum| faces << emotum if emotum.emotion.face_in_original? }
    faces
  end

  def self.detected_faces_in_processed
    faces = []
    Emotum.all.each { |emotum| faces << emotum if emotum.emotion.face_in_processed? }
    faces
  end

  def self.undetected_faces
    faces = []
    Emotum.all.each { |emotum| faces << emotum if (
      (!emotum.emotion.face_in_processed?) && (!emotum.emotion.face_in_original?)) }
    faces
  end

  def self.original_face_count; Emotum.detected_faces_in_original.count end

  def self.processed_face_count; Emotum.detected_faces_in_processed.count end

  def self.undetected_face_count; Emotum.undetected_faces.count end

  private

  # def has_image_url?
  #   !self.path.blank?
  # end

  # def download_remote_image
  #   self.avatar = download_remote_image
  #   self.avatar_remote_url = path
  # end

  # def download_remote_image
  #   io = open(URI.parse(path))
  #   def io.original_filename; base_uri.path.split('/').last; end
  #   io.original_filename.blank? ? nil : io
  # rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  # end
end
