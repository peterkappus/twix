module Twix  
  require 'twitter'
  require 'uri' #escaping

  def self.get_pic(query)
    tweet = url = ""
    tweets = Twitter.search("#{URI.escape query} (filter:images OR instagr.am OR pic.twitter.com)", :include_entities=>true, :rpp=>5).results

    tweets.shuffle.each do |t|
      if(t.urls.empty? && !t.media.empty?)
        tweet = t
        url = t.media.first.media_url unless t.media.empty?
        break
      else
        if (!t.urls.empty?)
          if(t.urls.first.expanded_url.match("http://instagr.am"))
            tweet = t
            #eg http://instagr.am/p/PcIUXpS6t5/ => http://instagr.am/p/PcIUXpS6t5/media/?size=l
            url = t.urls.first.expanded_url.gsub(%r{(?<=http://instagr.am/p/)(\w+/)},'\1media/?size=l') 
            break
          end
      
          #twitpic
          #eg http://twitpic.com/atrxtp
          if(t.urls.first.expanded_url.match("http://twitpic.com"))
            tweet = t
            #eg http://instagr.am/p/PcIUXpS6t5/ => http://instagr.am/p/PcIUXpS6t5/media/?size=l
            url = t.urls.first.expanded_url.gsub(%r{(?<=http://twitpic.com/)(\w+)},'show/large/\1') 
            break
          end
      
        end
      end
    end

    #puts "ERROR: no links found :( #{tweets}" if tweet.to_s.empty?  

    #puts "#{url}\n#{tweet.created_at.strftime("%Y-%m-%d")}   @#{tweet.from_user} #{tweet.text}\n"

    #-L => follow redirects
    #-s => Silent
    #{}`curl -Ls #{url} > #{Time.now.to_i.to_s}.jpg`

    return {:url=>url,:tweet=>tweet}
  end
  
  
  #twitpic
  #if (o[1] === "twitpic.com" || o[1] == "lightbox.com") {
  #           img_obj.thumbnail = "http://" + o[1] + "/show/thumb/" + o[2];
  #           img_obj.highres = "http://" + o[1] + "/show/large/" + o[2]
  #       }


  #from JS
  #instagram: http://instagr.am/5k5i53e6i
  #    img_obj.thumbnail = "http://" + o[1] + "/" + o[2] + "/media/?size=t";
  #    img_obj.highres = "http://" + o[1] + "/" + o[2] + "/media/?size=l"
  
  
end