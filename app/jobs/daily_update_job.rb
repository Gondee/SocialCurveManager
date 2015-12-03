class DailyUpdateJob < ActiveJob::Base
  queue_as :default

  # we assume that we have a class CsvImporter to handle the import
  def perform
     allgens = Generatedlink.where("paidout = ? AND dead = ?", false, false ) 
     allgens.each do |g|
        if(g.created_at > Time.now - (g.expire).days)
            if(g.created_at.to_date == (Time.now.day - (g.expire).days))    
                # Should Expire the link
                g.expire = true
                
                totalclicks = getTotalClicks(g.url)
                g.paidclicks = getTotalClicks(totalclicks)
                
                stat = Statistic.new
                
                stat.generatedlink_id = g.id
                stat.getTotalClicks(totalclicks)
                
                #save the changes
                g.save
                stat.save
            else
                stat = Statistic.new
                totalclicks = getTotalClicks(g.url)
                stat.generatedlink_id = g.id
                stat.getTotalClicks(totalclicks)
                stat.save
            end
          
          
        end
     end
  end
end