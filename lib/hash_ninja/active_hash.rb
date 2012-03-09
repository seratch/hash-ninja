# -*- encoding: utf-8 -*-

require "hash_ninja"
require "active_support/core_ext/array"
require "active_support/core_ext/hash/keys"

module HashNinja
  module ActiveHash

    def underscore_keys!
      self.keys.each do |key|
        value = delete(key)
        if key.is_a? String
          self[key.underscore] = value
        elsif key.is_a? Symbol
          self[key.to_s.underscore.to_sym] = value
        end
      end
      self
    end

    def classify_keys!
      self.keys.each do |key|
        value = delete(key)
        if key.is_a? String
          self[key.classify] = value
        elsif key.is_a? Symbol
          self[key.to_s.classify.to_sym] = value
        end
      end
    end

    def camelize_keys!
      self.keys.each do |key|
        value = delete(key)
        if key.is_a? String
          self[key.camelize] = value
        elsif key.is_a? Symbol
          self[key.to_s.camelize.to_sym] = value
        end
      end
    end

    def camelize_lower_keys!
      self.keys.each do |key|
        value = delete(key)
        if key.is_a? String
          self[key.camelize(:lower)] = value
        elsif key.is_a? Symbol
          self[key.to_s.camelize(:lower).to_sym] = value
        end
      end
    end

    def method_missing(name, *args, &block)
      # Generates 'recursively_xxx' methods
      if name.match(/recursively_/)
        method_name = name.to_s.sub(/^recursively_/, '')
        self.send(method_name, *args, &block)
        self.values.each do |value|
          if value.is_a? Hash
            value.extend HashNinja::ActiveHash
            value.send(name, *args, &block)
          elsif value.is_a? Array
            value.send(name, *args, &block)
          end
        end
        self
      end
    end

  end
end

class Array
  # for ActiveHash#recursively_xxx
  def method_missing(name, *args, &block)
    if name.match(/recursively_/) then
      method_name = name.to_s.sub(/^recursively_/, '')
      self.each do |value|
        if value.is_a? Hash
          value.extend HashNinja::ActiveHash
          value.send(name, *args, &block)
        elsif value.is_a? Array
          value.send(name, *args, &block)
        end
      end
      self
    end
  end
end

