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

  def diff_anger place = 4; (100*(anger_p - anger).truncate(place)) end
  def diff_contempt place = 4; (100*(contempt_p - contempt).truncate(place)) end
  def diff_disgust place = 4; (100*(disgust_p - disgust).truncate(place)) end
  def diff_fear place = 4; (100*(fear_p - fear).truncate(place)) end
  def diff_happiness place = 4; (100*(happiness_p - happiness).truncate(place)) end
  def diff_neutral place = 4; (100*(neutral_p - neutral).truncate(place)) end
  def diff_sadness place = 4; (100*(sadness_p - sadness).truncate(place)) end
  def diff_surprise place = 4; (100*(surprise_p - surprise).truncate(place)) end

  def average_original_scores
    arr = [anger, contempt, disgust, fear, happiness, neutral, sadness, surprise]
    sum = arr.inject(:+).to_f
    average = sum/arr.count
  end

  def average_processed_scores
    arr = [anger_p, contempt_p, disgust_p, fear_p, happiness_p, neutral_p, sadness_p, surprise_p]
    sum = arr.inject(:+).to_f
    average = sum/arr.count
    binding.pry
  end

  def face_in_original?
    (average_original_scores == 0) ? false : true
  end

  def face_in_processed?
    (average_processed_scores == 0) ? false : true
  end

  def self.color_diff_tag diff
    if diff > 0
      "<div class=\"text-success\">+#{diff}%</div>".html_safe
    elsif diff < 0
      "<div class=\"text-danger\">#{diff}%</div>".html_safe
    else
      "<div class=\"text-danger\">#{diff}%</div>".html_safe
    end
  end

  # Returns a sorted hash of all emotions
  def hashify
    emotions = {anger: anger, contempt: contempt, disgust: disgust, fear: fear,
                happiness: happiness, neutral: neutral, sadness: sadness, surprise: surprise}
    emotions.sort_by {|k, v| v}.reverse.to_h
  end

  def hashify_p
    emotions = {anger_p: anger_p, contempt: contempt_p, disgust_p: disgust_p, fear: fear_p,
                happiness_p: happiness_p, neutral_p: neutral_p, sadness_p: sadness_p, surprise_p: surprise_p}
    emotions.sort_by {|k, v| v}.reverse.to_h
  end

  def primary_score
    h = self.hashify
    [h.keys[0], h.values[0]]
  end

  def primary_score_p
    h = self.hashify_p
    [h.keys[0], h.values[0]]
  end

  def secondary_score
    h = self.hashify
    [h.keys[1], h.values[1]]
  end

  def secondary_score_p
    h = self.hashify_p
    [h.keys[1], h.values[1]]
  end
end
