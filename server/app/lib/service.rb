# frozen_string_literal: true

class Service
  def self.call(*args, **kwargs)
    instance = new
    kwargs.each { |k, v| instance.instance_variable_set("@#{k}", v) }
    instance.call
  end
end
