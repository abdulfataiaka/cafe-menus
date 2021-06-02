# frozen_string_literal

class UploadService
  STORAGE_PATH = Rails.root.join('storage')

  class << self
    def abspath(path)
      return if !path.is_a?(String) || path.strip.empty?

      STORAGE_PATH.join(path.strip)
    end

    def exist?(path)
      return false if path.nil?
      File.exist?(path)
    end

    def remove(path)
      path = abspath(path)
      return unless exist?(path)
      File.delete(path)
    end

    def get_file_mime(file)
      return unless file.content_type.is_a?(String)
      return if file.content_type.strip.empty?
      file.content_type.strip
    end
  
    def get_file_ext(file)
      mimetype = get_file_mime(file)
      return if mimetype.nil?
      parts = mimetype.split('/')
      return if parts.size <= 1
      parts[-1].downcase
    end

    def validate_file(file, **checks)
      unless file.is_a?(ActionDispatch::Http::UploadedFile)
        return ['is not a valid file object']
      end

      [].tap do |errors|
        validate_mimetype(file, checks, errors)
      end
    end

    def upload_file(file)
      extension = get_file_ext(file)
      path = "uploads/#{SecureRandom.uuid}"
      path += ".#{extension}" if extension
      File.open(abspath(path), "wb") { |fobj| fobj.write(file.read) }
      { path: path, errors: [] }
    end

    def upload_validated_file(file, **checks)
      errors = validate_file(file, **checks)
      return { path: nil, errors: errors } unless errors.empty?
      upload_file(file) 
    end

    private

    def validate_mimetype(file, checks, errors)
      match = checks[:mimetype]
      return if match.nil?

      mimetype = get_file_mime(file)
      errors << 'mimetype was not retrievable' if mimetype.nil?
      errors << 'mimetype is invalid' if mimetype && mimetype.match(match).nil?
    end
  end
end
