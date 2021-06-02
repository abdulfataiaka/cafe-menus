# frozen_string_literal: true

class MenuItemService
  class << self
    def find_menu_item(id)
      result = init_result
      record = MenuItem.find_by(id: id)

      if record
        result[:data] = record
        return result
      end

      result[:status] = :not_found
      result[:errors] << "Menu item with id `#{id}` not found"
      result
    end

    def create_menu_item(data)
      result = init_result

      photo = data.delete(:photo)
      upload_result = upload_photo(photo)

      unless upload_result[:errors].empty?
        result[:status] = :bad_request
        result[:errors] = upload_result[:errors]
        return result
      end

      record = MenuItem.create(photo: upload_result[:path], **data)
      errors = record.errors.full_messages

      unless errors.empty?
        result[:errors] = errors
        result[:status] = :bad_request
        UploadService.remove(upload_result[:path])
        return result
      end

      result[:data] = record
      result[:status] = :created
      result
    end

    def update_menu_item(data)
      id = data.delete(:id)
      result = find_menu_item(id)
      return result if result[:data].nil?
  
      photo = data.delete(:photo)
      upload_result = upload_photo(photo)

      unless upload_result[:errors].empty?
        result[:data] = nil
        result[:status] = :bad_request
        result[:errors] = upload_result[:errors]
        return result
      end

      record = result[:data]
      old_photo_path = record.photo
      record.assign_attributes(data)
      record.photo = upload_result[:path] if upload_result[:path]
      record.save
      errors = record.errors.full_messages

      unless errors.empty?
        result[:data] = nil
        result[:errors] = errors
        result[:status] = :bad_request
        UploadService.remove(upload_result[:path])
        return result
      end

      UploadService.remove(old_photo_path) if old_photo_path != record.photo
      result[:data] = record
      result
    end

    def delete_menu_item(id)
      result = find_menu_item(id)
      return result if result[:data].nil?

      result[:data].destroy
      result[:data] = result[:data].id
      result
    end

    private

    def init_result
      { status: :ok, data: nil, errors: [] }
    end

    def upload_photo(photo)
      return { path: nil, errors: [] } if photo.nil?
      
      UploadService.upload_validated_file(photo, mimetype: /^image\/.+$/).tap do |result|
        result[:errors].map! { |error| "Photo #{error}"}
      end
    end
  end
end
