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
  end

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
