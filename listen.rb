require 'listen'

listener = Listen.to('bin_emota') do |modified, added, removed|
	if !modified.empty? || !added.empty?
		fileName ||= added.first
		fileName ||= modified.first
		emotum = Emotum.create(emotum_params.merge on_server: true, name: fileName)
		puts 'Created an entry.................................'
    puts "Emotum count: #{Emotum.count}"
	else
		raise Exception # Something went wrong
	end
end

listener.start # not blocking
sleep
