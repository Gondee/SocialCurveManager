module LinksHelper
    
    #
    # https://github.com/joshnesbitt/google_url_shortener
    # Documentation of the Gem
    
    #Turn normal link into shortened link
    def createNewShortenedLink(originalURL)
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
