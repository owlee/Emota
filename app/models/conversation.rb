class Conversation < ActiveRecord::Base
  serialize :mood, Hash
  serialize :deviations, Hash

  validates :start_date, :end_date, presence: true

  scope :emota, -> { Emotum.where "created_at >= ? AND created_at <= ?", start_date, end_date }
  default_scope { order created_at: :asc }
end
