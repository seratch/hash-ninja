# -*- encoding: utf-8 -*-

require "hash_ninja"
require "active_support/core_ext/hash/keys"

module HashNinja

  # Hash with extended ActiveSupport
  #
  # See also {active_support/core_ext/hash/keys}[http://as.rubyonrails.org/classes/ActiveSupport/CoreExtensions/Hash/Keys.html]
  module ActiveHash

    # Applies ActiveSupport::Inflector.underscore to all the Hash#keys destructively.
    # Keys should be either Symbol or String.
    #
    # ==== Examples
    #   hash = {:rubyOnRails => 'http://rubyonrails.org/'}
    #   has.activate!.underscore_keys!  # => {:ruby_on_rails => 'http://rubyonrails.org/'}
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

    # Applies ActiveSupport::Inflector#classify to all the Hash#keys destructively.
    # Keys should be either Symbol or String.
    #
    # ==== Examples
    #   hash = {:ruby_on_rails => 'http://rubyonrails.org/'}
    #   has.activate!.classify_keys!  # => {:RubyOnRails => 'http://rubyonrails.org/'}
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

    # Applies ActiveSupport::Inflector#camelize to all the Hash#keys destructively.
    # Keys should be either Symbol or String.
    #
    # ==== Examples
    #   hash = {:ruby_on_rails => 'http://rubyonrails.org/'}
    #   has.activate!.camelize_keys!  # => {:RubyOnRails => 'http://rubyonrails.org/'}
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

    #
    # Applies ActiveSupport::Inflector#camelize(:lower) to all the Hash#keys destructively.
    # Keys should be either Symbol or String.
    #
    # ==== Examples
    #   hash = {:ruby_on_rails => 'http://rubyonrails.org/'}
    #   has.activate!.camelize_lower_keys!  # => {:rubyOnRails => 'http://rubyonrails.org/'}
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

    # Provides the following recursive methods.
    #
    # ====
    # * recursively_camelize_keys!
    # * recursively_camelize_lower_keys!
    # * recursively_classify_keys!
    # * recursively_underscore_keys!
    def method_missing(name, *args, &block)
      # provides 'recursively_xxx' methods
      if name.match(/recursively_/)
        method_name = name.to_s.sub(/^recursively_/, '')
        self.public_send(method_name, *args, &block)
        self.values.each do |value|
          if value.is_a? Hash
            value.extend HashNinja::ActiveHash
            value.public_send(name, *args, &block)
          elsif value.is_a? Array
            value.public_send(name, *args, &block)
          end
        end
        self
      end
    end

  end
end

class Array
  def method_missing(name, *args, &block)
    # for ActiveHash#recursively_xxx
    if name.match(/recursively_/)
      method_name = name.to_s.sub(/^recursively_/, '')
      self.each do |value|
        if value.is_a? Hash
          value.extend HashNinja::ActiveHash
          value.public_send(name, *args, &block)
        elsif value.is_a? Array
          value.public_send(name, *args, &block)
        end
      end
      self
    end
  end
end

