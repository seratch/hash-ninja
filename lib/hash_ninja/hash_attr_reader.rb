# -*- encoding: utf-8 -*-

module HashNinja

  # Provides attr_reader Hash data
  # ==== Examples
  #   member = {'name'=>'Andy', 'type' => { 'id' => 999, 'name' => 'Guest' }}.to_attr_reader
  #   member.name # => 'Andy'
  #   member.type.id # => 999
  class HashAttrReader
    # target Hash object
    attr_reader :hash

    # The 'hash' should be a Hash object.
    def initialize(hash)
      raise "hash should be a Hash object #{hash.to_s}" unless hash.is_a? Hash
      @hash = hash
    end

    def method_missing(name, *args, &block)
      found = @hash[name] || @hash[name.to_s]
      if found
        if found.is_a? Hash
          found.to_attr_reader
        else
          found
        end
      end
    end

    # Returns the Hash object held internally
    def to_hash
      @hash
    end

  end
end