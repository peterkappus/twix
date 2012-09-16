#https://github.com/peterkappus/twix
module Twix  
  require 'twitter'
  require 'uri' #escaping

  def self.get_pics(query,how_many=1)
    pics = []

    tweets = Twitter.search("#{URI.escape query} AND (instagr.am OR pic.twitter.com)", :include_entities=>true, :rpp=>how_many)

    #dumb hack. Otherwise, we get an error "undefined method 'results' for Array"
    tweets = tweets.results if how_many > 1

    
    tweets.each do |t|
      
      result = {}
      
      if(t.urls.empty? && !t.media.empty?)
        result[:tweet] = t
        result[:url] = t.media.first.media_url unless t.media.empty?
      else
        if (!t.urls.empty?)
          if(t.urls.first.expanded_url.match("http://instagr.am"))
            result[:tweet] = t
            #eg http://instagr.am/p/PcIUXpS6t5/ => http://instagr.am/p/PcIUXpS6t5/media/?size=l
            result[:url] = t.urls.first.expanded_url.gsub(%r{(?<=http://instagr.am/p/)([-\w]+/)},'\1media/?size=l') 
          end
      
          #twitpic
          #eg http://twitpic.com/atrxtp
          if(t.urls.first.expanded_url.match("http://twitpic.com"))
            result[:tweet] = t
            #eg http://instagr.am/p/PcIUXpS6t5/ => http://instagr.am/p/PcIUXpS6t5/media/?size=l
            result[:url] = t.urls.first.expanded_url.gsub(%r{(?<=http://twitpic.com/)([-\w]+)},'show/large/\1') 
          end
        end
      end
      
      if(result[:url].to_s.empty?)
        raise "No image found! text: #{t.text} urls: #{t.urls} media: #{t.media}"
      else
        pics << result
      end
      
    end


    return pics
    

  end
  
  def self.get_pic(query)
    return self.get_pics(query).first
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