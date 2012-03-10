# -*- encoding: utf-8 -*-

require "hash_ninja"
require "active_support/core_ext/string/inflections"

module HashNinja
  module CoreExt
  end
end

class Hash

  # Updates itself as HashNinja::ActiveHash destructively. 'active_support' will be also applied.
  def activate!
    self.extend HashNinja::ActiveHash
    self
  end

  # Provides HashNinja::HashAccessor object
  def to_hash_accessor
    HashNinja::HashAccessor.new(self)
  end

  # Creates Hash object which contains the readable instance variables of 'obj'.
  # It's possible to customize the key convention by 'key_strategy'.
  def self.from_attr(obj, key_strategy = :underscore)
    hash = {}
    obj.instance_variables.each do |attr|
      original_key = attr.to_s.delete('@')
      case key_strategy
        when :underscore
          key = original_key.underscore
        when :camelize
          key = original_key.camelize
        when :camelize_lower
          key = original_key.camelize(:lower)
        when :classify
          key = original_key.classify
        else
          key = original_key
      end
      begin
        hash[key.to_sym] = obj.send(original_key.to_sym)
      rescue NoMethodError => e
      end
    end
    hash
  end

end
