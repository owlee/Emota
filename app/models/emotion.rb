class Emotion < ActiveRecord::Base
  has_one :emotum

  after_initialize :update_defaults

  def update_defaults
    self.anger ||= 0.0
    self.contempt ||= 0.0
    self.disgust ||= 0.0
    self.fear ||= 0.0
    self.happiness ||= 0.0
    self.neutral ||= 0.0
    self.sadness ||= 0.0
    self.surprise ||= 0.0

    self.anger_p ||= 0.0
    self.contempt_p ||= 0.0
    self.disgust_p ||= 0.0
    self.fear_p ||= 0.0
    self.happiness_p ||= 0.0
    self.neutral_p ||= 0.0
    self.sadness_p ||= 0.0
    self.surprise_p ||= 0.0
  end

  def diff_anger place = 4; (100*(self.anger - self.anger_p).truncate(place)) end
  def diff_contempt place = 4; (100*(self.contempt - self.contempt_p).truncate(place)) end
  def diff_disgust place = 4; (100*(self.disgust - self.disgust_p).truncate(place)) end
  def diff_fear place = 4; (100*(self.fear - self.fear_p).truncate(place)) end
  def diff_happiness place = 4; (100*(self.happiness - self.happiness_p).truncate(place)) end
  def diff_neutral place = 4; (100*(self.neutral - self.neutral_p).truncate(place)) end
  def diff_sadness place = 4; (100*(self.sadness - self.sadness_p).truncate(place)) end
  def diff_surprise place = 4; (100*(self.surprise - self.surprise_p).truncate(place)) end

  # Returns a sorted hash of all emotions
  def hashify
    emotions = {anger: anger, contempt: contempt, disgust: disgust, fear: fear,
                happiness: happiness, neutral: neutral, sadness: sadness, surprise: surprise}
    emotions.sort_by {|k, v| v}.reverse.to_h
  end

  def primary_score
    h = self.hashify
    [h.keys[0], h.values[0]]
  end

  def secondary_score
    h = self.hashify
    [h.keys[1], h.values[1]]
  end
end
