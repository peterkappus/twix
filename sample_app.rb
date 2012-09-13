require './twix.rb'

#puts "#{url}\n#{tweet.created_at.strftime("%Y-%m-%d")}   @#{tweet.from_user} #{tweet.text}\n"

#get a pic
pic = Twix.get_pic("awesome")

#print the text of the tweet
puts pic[:tweet].text

#download it (-s silent -L follow redirect)
`curl -Ls #{pic[:url]} > #{Time.now.to_i.to_s}.jpg`
