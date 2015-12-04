module StatsupdatersHelper
    
    def runUpdater
         DailyupdaterJob.perform_later
    end
    
    
end
