require 'net/http'
require 'json'


r = Net::HTTP.get("mwo.smurfy-net.de", "/api/data/mechs")
p = JSON.parse(r)


# Print a mech structure
pp p.first and nil


# query a mech to get csv outputs for mediums available for C-Bills

p.map {|mech| 
  mech if mech[1]["mech_type"] == "medium" 
}.compact.select { |mech| 
  mech[1]["details"]["price"]["cb"] != -1 
}.each { |mech| 
  name = mech[1]["translated_short_name"]
  tons = mech[1]["details"]["tons"]
  armor = mech[1]["details"]["max_armor"]
  puts "#{name.ljust(12, " ")},  #{tons}, #{armor}"
} and nil

