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
end
