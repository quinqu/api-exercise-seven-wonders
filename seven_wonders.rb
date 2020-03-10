require 'httparty'
require 'dotenv'

BASE_URL = "https://us1.locationiq.com/v1/search.php"  
Dotenv.load

def get_location(search_term)
  #sets up the query parameters
    query_parameters = {
    key: ENV["API_KEY"],
    q: search_term
  }

  response = HTTParty.get(BASE_URL, query: query_parameters).to_h
  #use API here
  search = response["searchresults"]["querystring"]
  #puts response["searchresults"]["place"]
  latitude = response["searchresults"]["place"]["lat"]
  longitude = response["searchresults"]["place"]["lon"]
  
  return search => {:lat => latitude, :lon => longitude}

end


def find_seven_wonders

  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end

  return seven_wonders_locations
end


# Expecting something like:
# [{"Great Pyramid of Giza"=>{:lat=>"29.9791264", :lon=>"31.1342383751015"}}, {"Gardens of Babylon"=>{:lat=>"50.8241215", :lon=>"-0.1506162"}}, {"Colossus of Rhodes"=>{:lat=>"36.3397076", :lon=>"28.2003164"}}, {"Pharos of Alexandria"=>{:lat=>"30.94795585", :lon=>"29.5235626430011"}}, {"Statue of Zeus at Olympia"=>{:lat=>"37.6379088", :lon=>"21.6300063"}}, {"Temple of Artemis"=>{:lat=>"32.2818952", :lon=>"35.8908989553238"}}, {"Mausoleum at Halicarnassus"=>{:lat=>"37.03788265", :lon=>"27.4241455276707"}}]
#its returning an array of hashes 
#API Rate Limiting: To prevent an API from being overwhelmed, API owners often enforce a limit on the number of requests, or the quantity of data clients can consume. 
#Sleep Method: this method halts the program for seconds given 


#What is the base URL for this call? You will need to look at the Location IQ Geocoding documentation to find the answer.

# the base URL is: "https://us1.locationiq.com/v1/search.php"  

# What is the HTTParty syntax to set the query parameters for this call? What needs to be part of the query parameters?

#this is the syntax:
# query_parameters = {
#   key: ENV["API_KEY"], ---- your private API Key 
#   q: search_term -----search term 
# }

# 
# What does the response that comes back from the Location IQ API look like? How do we check or verify? What debugging tools can we use?

# it looks like a hash , we can check by puts-ing it into the terminal 


# Hint: After discovering what the response from Location IQ looks like, if you see "multiple" coordinates, pick the "first" one.