module LinksHelper
    require 'uri'
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
    
   
    #total clicks in each country, hash {COUNTRY => CLICKS} #Need to set the countries
    def getCountryClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.all.countries # => { "GB" => 1 }

    end
    def getPlatformClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.all.platforms # => { "GB" => 1 }

    end
    
    def getReferrersClicks(shortURL)
        Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
        url = Google::UrlShortener::Url.new(:short_url => shortURL)
        url.expand! #Documentation says it needs to be expanded to get the analytics
        return url.analytics.all.referrers # => { "GB" => 1 }

    end
    
    
    
    
    def getlinkcpm(genlink)
        #Later on need to put in the cut for us to make $$ with
        go = Link.where("id = ?",genlink.link_id).first
        go.cpm
    
    end
    
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
    
    def getDashboardGraphStats
       
        links = Generatedlink.where("user_id = ? AND dead = ?", current_user_id, false )
        #links.reorder("created_at")
        # => probably a bad solution, building inital structure
        data = []
        for d in (7).downto(0)
            data << [d,0]
        end
        
        #=> look through the list of links and create the sub arrays that will be added to the master
        links.each do |l| 
            #weekarray =>put the last 7 days clicks in a array. This is the total clicks in each day, so will need to do math get the per day values. 
            weekarray = []
            for d in (7).downto(0)
                # daystats => All the statstics for this generated link on (Today - d) days. Get latest record in that day as the value to use. 
                daystats = Statistic.where("created_at >= ? AND created_at <= ? AND generatedlink_id = ?", d.days.ago.beginning_of_day,d.days.ago.end_of_day, l.id ) #to_date - d.days)
                
                if(daystats.length != 0)
                    dayarray = [d, daystats.maximum(:clicks)]
                    weekarray << dayarray
                else
                    weekarray << [d,0]
                end
                
            end
            
            #return weekarray
            #get per day clicks - Does not include 0 - Data is stored as accumulations. so must break that down to where it is daily
            for d in 1..7
                weekarray[d][1] -= weekarray[d-1][1]
            end
            #Add that links weekly stats to the list of weekly stats
            for d in (7).downto(0)
                data[d][1] += weekarray[d][1]
            end
        end
        
        #return the list of everything
        return data
    end
    
    def getCountryStatisticsForBarChart(url)
        data = getCountryClicks(url)
        
        names = []
        values = []
        i =0;
        
        data.each do |key, var|
            names << [i,key]
            values << [i,var]
            i+=1
        end
        
        return names, values
    end
    
    def getPlatformStatisticsForBarChart(url)
        data = getPlatformClicks(url)
        
        names = []
        values = []
        i =0;
        
        data.each do |key, var|
            names << [i,key]
            values << [i,var]
            i+=1
        end
        
        return names, values
    end
    
    def getReferrersStatisticsForBarChart(url)
        data = getReferrersClicks(url)
        
        names = []
        values = []
        i =0;
        
        data.each do |key, var|
            names << [i,key]
            values << [i,var]
            i+=1
        end
        
        return names, values
    end
    
    String.class_eval do
    def is_valid_url?
        uri = URI.parse self
        uri.kind_of? URI::HTTP
    rescue URI::InvalidURIError
        false
    end
    
end
    
end
