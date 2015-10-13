class Message < ActiveRecord::Base
	validates :unsubscriber_id, uniqueness: {scope: :unsubscribed_id}
end
