# frozen_string_literal: true

class MenuItem < ApplicationRecord
  self.inheritance_column = :_type_disabled

  ALLOWED_TYPES = %w[side main_course]

  validates :name, :price, :type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :type, inclusion: { in: ALLOWED_TYPES, message: 'provided not supported' }
  validates_format_of :price, with: /\A\$\d+\z/, message: "format is not valid"

  before_save :titleize_name

  def titleize_name
    self.name = self.name.titleize
  end
end
