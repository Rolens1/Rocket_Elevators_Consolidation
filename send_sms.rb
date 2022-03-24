# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'

account_sid = 'AC5931e3620b3a6b8408eb5872ab2a544b'
auth_token = 'TWILIO_KEY'
client = Twilio::REST::Client.new(account_sid, auth_token)

from = '+17069898933' # Your Twilio number
to = '+15146862467' # Your mobile phone number

client.messages.create(
from: from,
to: to,
body: "#{elevator_id} has a problem. It needs to be verified as soon as possible. Thank you for your hard work and have a good day!"
)