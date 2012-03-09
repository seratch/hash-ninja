# -*- encoding: utf-8 -*-

module HashNinja
  class HashAccessor
    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    def method_missing(name, *args, &block)
      if @hash.key? name
        found = @hash[name]
        if found.is_a? Hash
          found.to_hash_accessor
        else
          found
        end
      end
    end

    def to_hash
      @hash
    end

  end
end