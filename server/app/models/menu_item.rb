# frozen_string_literal: true

class MenuItem < ApplicationRecord
  self.inheritance_column = :_type_disabled

  ALLOWED_TYPES = %w[side main_course]

  before_save :transform_data

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :type, presence: true, inclusion: { in: ALLOWED_TYPES, message: 'provided not supported' }
  validates :price, presence: true, format: { with: /\A\$\d+\z/, message: "format is not valid" }
  validates :photo, allow_nil: true, allow_blank: true, uniqueness: { case_sensitive: false }

  def transform_data
    self.name = self.name.downcase.titleize
  end

  def photo_saved?
    return false if photo.nil?
    File.exist?(Rails.root.join("storage/#{photo}"))
  end
end
