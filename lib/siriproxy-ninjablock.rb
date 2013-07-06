require 'rubygems'
require 'cora'
require 'siri_objects'
require 'ninja_blocks'
require 'pp'
require 'addressable/uri'

#######
# This is an extendable plugin/wrapper for the NinjaBlock platform. 
# It intercepts the different phrases interfaces with the NinjaBlock API.
#
######

class SiriProxy::Plugin::Ninja < SiriProxy::Plugin

  OBJECT = "(?:the )?(.*?)"
  OBJECT_GREEDY = "(?:the )?(.*)"
  SIRI_NUMBER_WORDS = "zero|one|two|three|four|five|six|seven|eight|nine"
  DURATION = "(1?[0-9]?[0-9]|#{SIRI_NUMBER_WORDS})"
  DURATION_UNIT = "(seconds|minutes|hours)"
  PERCENTAGE = "(1?[0-9]?[0-9]|#{SIRI_NUMBER_WORDS})"
  TEMPERATURE = "(-?1?[0-9]?[0-9]\.?[0-9]?|#{SIRI_NUMBER_WORDS})"
  
  def initialize(config)
    if config["url"].nil?
      puts "[Error - NinjaBlock] Missing configuration, the NinjaBlock token must be defined in your config.yml file. Find your token at https://a.ninja.is/you" 
    else
      ::NinjaBlocks::token = config["token"]
      reload_configuration
    end
  end

  #Reloads configuration from the HaikuHelper server
  def reload_configuration
    puts "[Info - NinjaBlock] Reloading NinjaBlock configuration..."

    @devices = ::NinjaBlocks::Device.list
    @rules = ::NinjaBlocks::Rule.list
    @user = ::NinjaBlocks::User.info
  end

  
    #Parses a siri number
  def parse_siri_number(number)
    case number
    when "zero"  then 0
    when "one"   then 1
    when "two"   then 2
    when "three" then 3
    when "four"  then 4
    when "five"  then 5
    when "six"   then 6
    when "seven" then 7
    when "eight" then 8
    when "nine"  then 9
    else         number.to_i
    end
  end


  listen_for /list ninja block devices/i do
    say "The Ninja Block is connected to these devices: #{devices}" #say something to the user!

    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  listen_for /list ninja block rules/i do
    say "The Ninja Block is running these rules: #{rules}" #say something to the user!

    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end
  
  listen_for /(show|who are) the ninja block (users|user)/i do
    say "The Ninja Block is being used by: #{user}" #say something to the user!

    request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  end


# Demonstrate that you can have Siri say one thing and write another"!
#   listen_for /you don't say/i do
#     say "Sometimes I don't write what I say", spoken: "Sometimes I don't say what I write"
#   end
# 
# demonstrate state change
#   listen_for /siri proxy test state/i do
#     set_state :some_state #set a state... this is useful when you want to change how you respond after certain conditions are met!
#     say "I set the state, try saying 'confirm state change'"
# 
#     request_completed #always complete your request! Otherwise the phone will "spin" at the user!
#   end
# 
#   listen_for /confirm state change/i, within_state: :some_state do #this only gets processed if you're within the :some_state state!
#     say "State change works fine!"
#     set_state nil #clear out the state!
# 
#     request_completed #always complete your request! Otherwise the phone will "spin" at the user!
#   end
# 
# demonstrate asking a question
#   listen_for /siri proxy test question/i do
#     response = ask "Is this thing working?" #ask the user for something
# 
#     if(response =~ /yes/i) #process their response
#       say "Great!"
#     else
#       say "You could have just said 'yes'!"
#     end
# 
#     request_completed #always complete your request! Otherwise the phone will "spin" at the user!
#   end
# 
# demonstrate capturing data from the user (e.x. "Siri proxy number 15")
#   listen_for /siri proxy number ([0-9,]*[0-9])/i do |number|
#     say "Detected number: #{number}"
# 
#     request_completed #always complete your request! Otherwise the phone will "spin" at the user!
#   end
# 
# demonstrate injection of more complex objects without shortcut methods.
#   listen_for /test map/i do
#     add_views = SiriAddViews.new
#     add_views.make_root(last_ref_id)
#     map_snippet = SiriMapItemSnippet.new
#     map_snippet.items << SiriMapItem.new
#     utterance = SiriAssistantUtteranceView.new("Testing map injection!")
#     add_views.views << utterance
#     add_views.views << map_snippet
# 
#     #you can also do "send_object object, target: :guzzoni" in order to send an object to guzzoni
#     send_object add_views #send_object takes a hash or a SiriObject object
# 
#     request_completed #always complete your request! Otherwise the phone will "spin" at the user!
#   end
end
