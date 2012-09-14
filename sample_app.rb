require './twix.rb'

#get one pic
pic = Twix.get_pic("awesome")

#print the text of the tweet
puts pic[:tweet].text

#download the image file (-s silent -L follow redirect)
`curl -Ls #{pic[:url]} > #{Time.now.to_i.to_s}.jpg`




#get several pics
pics = Twix.get_pics("lol",10)

#print the urls as a string
puts pics.map{|p| p[:url]}.join("\n")