puts '##### Seeding Emota Image Set #####'

# Simulate Conversations
dir = Rails.application.root + 'db/emota_image_set/'

count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }

Emotum.destroy_all
(0...count).each do |minute|
  if count % 10 == 0
    puts '### Ending conversation ###'
    sleep(1.minute)
    puts '### Waking up to new conversation ###'
  end
  puts Time.now
  Dir.glob((dir + '*.jpg').to_s) { |image_path| Emotum.build image_path, 0, 1 }
end

puts Time.now
puts '##### Seeding Emota Image Set has complete #####'
