# frozen_string_literal: true

class MenuItemService
  def self.create(**kwargs)
    new.tap do |instance|
      kwargs.each { |k, v| instance.instance_variable_set("@#{k}", v) }
    end
  end

  def find_menu_item
    errors = []
    record = MenuItem.find_by(id: @id)
    errors << "Menu item with id `#{@id}` not found" if record.nil?
    { data: record, errors: errors }
  end

  def create_menu_item
    path, errors = upload_photo
    return { data: nil, errors: errors } if errors.any?

    record = MenuItem.create(photo: path, **parameters)

    { data: record, errors: record.errors.full_messages }.tap do |result|
      if result[:errors].any?
        result[:data] = nil
        delete_photo(path)
      end
    end
  end

  def update_menu_item
    result = find_menu_item
    record = result[:data]
    return result if record.nil?

    old_path = record.photo_saved? ? record.photo : nil
    new_path, errors = upload_photo
    return { data: nil, errors: errors } if errors.any?

    record.assign_attributes(parameters)
    record.photo = new_path if new_path
    record.save

    { data: record, errors: record.errors.full_messages }.tap do |result|
      if result[:errors].any?
        result[:data] = nil
        delete_photo(new_path)
      end

      delete_photo(old_path) if record.photo != old_path
    end
  end

  def delete_menu_item
    result = find_menu_item
    record = result[:data]
    return result if record.nil?

    record.destroy
    { data: record.id, errors: [] }
  end

  private

  def parameters
    { name: @name, price: @price, type: @type }.compact
  end

  def photo_valid?
    @photo.is_a?(ActionDispatch::Http::UploadedFile)
  end

  def delete_photo(path)
    return if path.nil?
    File.delete(Rails.root.join("storage/#{path}"))
  end

  def upload_photo
    path = nil; errors = []

    if photo_valid? && !/^image\/.+$/.match(@photo.content_type)
      errors << "Photo mimetype is invalid"
    end

    if photo_valid? && errors.empty?
      ext = @photo.content_type.split("/")[-1].downcase
      path = "uploads/#{SecureRandom.uuid}.#{ext}"
      upload_path = Rails.root.join("storage/#{path}")
      File.open(upload_path, "wb") { |file| file.write(@photo.read) }
    end

    [ path, errors ]
  end
end
