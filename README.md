Twix
====

Get pictures from Twitter (currently pic.twitter.com or Instagram) who's parent tweets match a given query. 

get_pics(query,how_many)
returns an array of hashes with a [:url] string and a [:tweet] object 

Uses the awesome twitter gem behind the scenes.


##Installation:
	
	%> bundle install
	
##Usage:
	
	require './twix.rb'
	pic = Twix.get_pic("awesome")
	puts pic[:url]
	puts pic[:tweet].text
	
	pics = Twix.get_pics("lol",20)
	
