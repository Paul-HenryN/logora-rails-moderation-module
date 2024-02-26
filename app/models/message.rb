class Message < ApplicationRecord
    include Moderable
    validates :body, presence: true

    def perform_moderation
        fields = [self.body]
        moderate(fields)
    end
end
