# -*- encoding: utf-8 -*-

require "hash_ninja"

describe HashNinja::HashAccessor do

  it 'should be available with string keys' do
    hash = {:something => 'like that', :name => 'hash_ninja'}
    hash_accessor = hash.to_hash_accessor
    hash_accessor.something.should eq('like that')
    hash_accessor.name.should eq('hash_ninja')
  end

  it 'should be available with symbol keys' do
    hash = {:something => 'like that', :name => 'hash_ninja'}
    hash_accessor = hash.to_hash_accessor
    hash_accessor.something.should eq('like that')
    hash_accessor.name.should eq('hash_ninja')
  end

  it 'should be available with nested hash' do
    hash = {
        :something => 'like that',
        :nested => {
            :name => 'hash_ninja',
            :since => 2012
        }
    }
    hash_accessor = hash.to_hash_accessor
    hash_accessor.something.should eq('like that')
    hash_accessor.nested.name.should eq('hash_ninja')
    hash_accessor.nested.since.should eq(2012)
  end

end