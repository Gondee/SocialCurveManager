class DailyupdaterJob < ActiveJob::Base
  queue_as :default

  def perform
      
     allgens = Generatedlink.where("paidout = ? AND dead = ?", false, false ) 
     allgens.each do |g|
        if(g.created_at > Time.now - (g.expire).days)
            if(g.created_at.to_date == (Time.now.day - (g.expire).days))    
                # Should Expire the link
                g.expire = true
                
                #calling the API
                Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
                url = Google::UrlShortener::Url.new(:short_url => g.url)
                url.expand!
                totalclicks = url.analytics.all.short_url_clicks
                
                #update values
                g.paidclicks = totalclicks
                stat = Statistic.new
                stat.generatedlink_id = g.id
                stat.clicks = totalclicks
                
                #save the changes
                g.save
                stat.save
            else
                
                Google::UrlShortener::Base.api_key = "AIzaSyDAT2500mxvTeoAVStBL5LebEfgqpDU8vw"
                url = Google::UrlShortener::Url.new(:short_url => g.url)
                url.expand! 
                totalclicks = url.analytics.all.short_url_clicks
                
                #add value
                stat = Statistic.new
                stat.generatedlink_id = g.id
                stat.clicks = totalclicks
                stat.save
                puts "HELPPPPPPPPPPPPPP"
            end
          
          
        end
     end
  end
end
