puts 'Seeding Emota Image Set'
puts Time.now
Emotum.destroy_all
Dir.glob((Rails.application.root+'db/emota_image_set/*.jpg').to_s) do |image_path|
  Emotum.build image_path, 0, 1
end
puts Time.now
puts 'Seeding Emota Image Set has complete'
