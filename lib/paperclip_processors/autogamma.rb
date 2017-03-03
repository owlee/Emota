module Paperclip
  class Autogamma < Processor
    def make
      basename = File.basename(@file.path, File.extname(@file.path))
      dst_format = options[:format] ? ".#{options[:format]}" : ''

      dst = Tempfile.new([basename, dst_format])
      dst.binmode
      argument = '-c luminance'

      binding.pry
      `lib/paperclip_processors/autogamma #{argument} #{File.expand_path(@file.path)} #{File.expand_path(dst.path)}.jpg`
      `mv #{File.expand_path(dst.path)}.jpg #{File.expand_path(dst.path)}`
      dst
    end
  end
end
