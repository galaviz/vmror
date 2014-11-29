desc "This task is called by the Heroku scheduler add-on"

#Run it locally by typing the command: rake read_emails
task :read_emails => :environment do
  puts "Reading monitoring emails"

  #Config
  Mail.defaults do
     retriever_method :imap, { :address             => "imap.googlemail.com",
                               :port                => 993,
                               :user_name           => 'energymonitoring@verdemonarca.com',
                                :password            => 'Energy13524',
                               :enable_ssl          => true }
  end

  #read emails
  emails = Mail.all#TODO: Use Mail.find to only process recent emails
  emails.each do |email|
    if email.attachments.length > 0 # TODO: add extra check to avoid processing redundant emails
      email.attachments.each do | attachment |
        #puts attachment.inspect

        #Create temp file. TODO: Figure out a way to parse .xlsx directly from file stream. Roo requires an actual file
        filename = attachment.filename
        tmpFilename = "#{Rails.root.to_s}/tmp/" + filename
        begin
          File.open( tmpFilename, "w+b", 0644) {|f| f.write attachment.body.decoded}
        rescue => e
          puts "Unable to save data for #{filename} because #{e.message}"
        end

        # Parse email -- > dump to database
        s = Roo::Excelx.new(tmpFilename)
        s.default_sheet = s.sheets.first
        puts s.cell(2,3)
        s.default_sheet = s.sheets.second
        puts s.cell(2,3)
      end
    end
  end
end

