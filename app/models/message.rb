class Message < ApplicationRecord
    include Moderable
    validates :body, presence: true
end
