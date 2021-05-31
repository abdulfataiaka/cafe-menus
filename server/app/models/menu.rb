# frozen_string_literal: true

class Menu < ApplicationRecord
  self.inheritance_column = :_type_disabled

  enum type: [:side, :main_course]

  validates :name, :price, :type, presence: true
end
