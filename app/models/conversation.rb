class Conversation < ActiveRecord::Base
  serialize :mood, Hash
  serialize :deviations, Hash

  validates :start_date, :end_date, presence: true

  default_scope { order created_at: :asc }

  scope :find_by_date, -> (date) { where('created_at >= ? AND created_at <= ?', date.to_datetime.beginning_of_day, date.to_datetime.end_of_day) }

  def emota
    Emotum.where "created_at >= ? AND created_at <= ?", start_date, end_date
  end
end
