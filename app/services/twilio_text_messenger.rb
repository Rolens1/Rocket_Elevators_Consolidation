class TwilioTextMessenger
    attr_reader :message
  
    def initialize(message)
      @message = message
    end
  
    def call
      client = Twilio::REST::Client.new
      client.messages.create({
        from: '+17069898933',
        to: '+15146862467',
        body: '#{Elevator.ID} is defective. Please go check out on the elevator as soon as possible. Have a good day!'
      })
    end
  end