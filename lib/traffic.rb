require 'nokogiri'
require 'net/http'
require 'time-lord'

namespace :traffic do
	desc 'find and notify of new traffic issues in Indianapolis'
	task :check do
		Pushover.configure do |config|
			config.user  = ENV['USER_TOKEN']
			config.token = ENV['APP_TOKEN']
		end
		doc = Nokogiri::HTML(Net::HTTP.get(URI.parse('http://pws.trafficwise.org/ipws/ci/')))
		doc.css('table#inc-table tr :nth-child(3) div.style2 div').collect do |x|
			if !Record.where(message: x.content, :expires.gt => Time.now.utc).exists?
				Pushover.notification(message: x.content, title: 'Traffic Alert!')
				future = Time.now + 1.week.from_now.to_i
				Record.create(message: x.content, expires: future.utc)
			end
		end
	end

	desc 'cleanup any expired records'
	task :cleanup do
		Record.where(:expires.lte => Time.now.utc).destroy
	end

	desc 'remove all records'
	task :dump do
		Record.all.destroy
	end
end