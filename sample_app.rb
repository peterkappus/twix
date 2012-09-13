require './twix.rb'

#get a pic
pic = Twix.get_pic("awesome")

#print the text of the tweet
puts pic[:tweet].text

#download the image file (-s silent -L follow redirect)
`curl -Ls #{pic[:url]} > #{Time.now.to_i.to_s}.jpg`
