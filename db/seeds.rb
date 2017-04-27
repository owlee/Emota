puts '##### Seeding Emota Image Set #####'

# Simulate Conversations
dir1 = Rails.application.root + 'db/emota_image_set/'
dir2 = Rails.application.root + 'db/convo_set/'

Emotum.destroy_all
Emotion.destroy_all
Conversation.destroy_all

puts Time.now

#count = 1
#Dir.glob((dir1 + '*.jpg').to_s) do |image_path|
#  if count % 8 == 0
#    puts 'Seeding Test'
#    puts '### Ending conversation ###'
#    sleep(3.minute)
#    puts '### Waking up to new conversation ###'
#  end
#  Emotum.build image_path, 0, 1, 0
#  count += 1
#end
#
#Dir.glob((dir2 + '*.jpg').to_s) do |image_path|
#  if count % 8 == 0
#    puts 'Seeding Convo Set'
#    puts '### Ending conversation ###'
#    sleep(3.minute)
#    puts '### Waking up to new conversation ###'
#  end
#  Emotum.build image_path, 0, 1, 0
#  count += 1
#end
puts Time.now
puts '##### Seeding Emota Image Set has complete #####'
