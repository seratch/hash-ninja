# -*- encoding: utf-8 -*-

require "hash_ninja"
require "active_support/core_ext/string/inflections"

module HashNinja
  module CoreExt
  end
end

class Hash

  def extend_active_hash!
    self.extend HashNinja::ActiveHash
  end

  def to_hash_accessor
    HashNinja::HashAccessor.new(self)
  end

  def self.from_attr(obj, key_strategy = :underscore)
    hash = {}
    obj.instance_variables.each do |attr|
      original_key = attr.to_s.delete('@')
      if key_strategy == :underscore
        key = original_key.underscore
      elsif key_strategy == :classify
        key = original_key.classify
      elsif key_strategy == :camelize
        key = original_key.camelize
      elsif key_strategy == :camelize_lower
        key = original_key.camelize(:lower)
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
