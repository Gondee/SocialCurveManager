module LinksHelper
    
    #
    # https://github.com/joshnesbitt/google_url_shortener
    # Documentation of the Gem
    
    #Turn normal link into shortened link
    def createNewShortenedLink(originalURL)
        originalURL = originalURL + "##{SecureRandom.hex(6)}"
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:long_url => originalURL)
        return url.shorten!
    end
    
    #return a shortened link back to its long form
    def shortBackToLongLink(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        return url.expand!
    end
    
    #assign a user the generated link
    #def giveGeneratedLinkToUser()
        #Not sure if this functionality can go here. 
    #end
    
    def cacheclicks?(link)
       if(link.updated_at < DateTime.now.beginning_of_hour)
           true
       else
           false
       end
        
    end
    
    def cacheclicks(shorturl)
        puts 'cacheclicks'
        locallink = Generatedlink.find_by url: shorturl
        if(cacheclicks?(locallink))
            locallink.clicks = getTotalClicks(shorturl) #update the clicks
            locallin.updated_at = DateTime.current
            locallink.save
        end
    end
    
   
    #total clicks in each country, tuple <string, int> #Need to set the countries
    # def getCountryClicks(shortURL)
    #     Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
    #     url = Google::UrlShortener::Url.new(:short_url => shortURL)
    #     url.expand! #Documentation says it needs to be expanded to get the analytics
    #     return url.analytics.all.countries # => { "GB" => 1 }

    # end
    
    
    #Getting Stats By Time
    def getTwoHoursClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.two_hours.short_url_clicks
    end
    
     #total clicks on the current day
    def getTodayClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.day.short_url_clicks
    end
    
    def getWeeklyClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.week.short_url_clicks
    end
    
    #monthly clicks on all links, tuple <url, clicks>
    def getMonthlyClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.month.short_url_clicks
    end
    
    #total clicks on particular link 
    def getTotalClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        #cacheclicks(shortURL) #ensure its saved. 
        
        
        #updating the cache. Users cache so publishers can pull large records. 
        locallink = Generatedlink.find_by url: shortURL
        locallink.clicks = url.analytics.all.short_url_clicks #update the clicks
        locallink.updated_at = DateTime.current
        locallink.save
    
        
        
        
        return url.analytics.all.short_url_clicks
    end
    
    #Return the date in the formated listed here. 
    def getCreatedDate(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.created_at # => 2011-01-11
    end
    
end
