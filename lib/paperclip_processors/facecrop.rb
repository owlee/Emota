module Paperclip
  class Facecrop < Processor
    def make
      basename = File.basename(@file.path, File.extname(@file.path))
      dst_format = options[:format] ? ".#{options[:format]}" : ''

      dst = Tempfile.new([basename, dst_format])
      dst.binmode
      binding.pry

      convert(':src -type Grayscale :dst',
              src: File.expand_path(@file.path),
              dst: File.expand_path(dst.path))
      dst
    end
  end
end
