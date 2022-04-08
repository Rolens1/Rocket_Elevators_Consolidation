class Intervention < ApplicationRecord
    after_save do |intervention|
        FdService.new(intervention).send_ticket
    end
end
