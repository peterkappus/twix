Twix
====

Get tweets from Twitter which match keywords. Single function "get_pic(query)" returns a hash with a URL and a twitter object (using the twitter gem).


##Installation:
	
	%> bundle install
	
##Usage:
	
	require './twix.rb'
	pic = Twix.get_pic("awesome")
	puts pic[:url]
	puts pic[:tweet].text