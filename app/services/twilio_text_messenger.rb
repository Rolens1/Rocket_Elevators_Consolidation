class TwilioTextMessenger
    attr_reader :message
  
    def initialize(message)
      @message = message
    end
  
    def call
      client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_KEY'])
      client.messages.create({
        from: '+17069898933',
        to: '+14388697178',
        body: message
      })
    end
  end