class Elevator < ApplicationRecord
    belongs_to :column
    after_update :status_update
    
    def status_update
        if self.Status == "Intervention"
            TwilioTextMessenger.call
        end
    end
end