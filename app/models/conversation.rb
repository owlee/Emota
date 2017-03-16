class Conversation < ActiveRecord::Base
  serialize :mood, Hash
  serialize :deviations, Hash
end
