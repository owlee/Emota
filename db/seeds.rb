puts 'Seeding Emota Image Set'
Dir.glob((Rails.application.root+'db/emota_image_set/*.jpg').to_s) do |image_path|
  Emotum.build image_path, 0, 1
end
puts 'Seeding Emota Image Set has complete'
