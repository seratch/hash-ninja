# -*- encoding: utf-8 -*-

require "hash_ninja"

describe HashNinja::HashAccessor do

  it 'should work with string keys' do
    hash = {:something => 'like that', :name => 'hash_ninja'}
    ha = hash.to_hash_accessor

    ha.something.should eq('like that')
    ha.name.should eq('hash_ninja')
  end

  it 'should work with symbol keys' do
    hash = {:something => 'like that', :name => 'hash_ninja'}
    ha = hash.to_hash_accessor

    ha.something.should eq('like that')
    ha.name.should eq('hash_ninja')
  end

  it 'should work with nested hash' do
    hash = {
        :something => 'like that',
        :nested => {
            :name => 'hash_ninja',
            :since => 2012
        }
    }
    ha = hash.to_hash_accessor

    ha.something.should eq('like that')
    ha.nested.name.should eq('hash_ninja')
    ha.nested.since.should eq(2012)
  end

  it 'should work with keys which contains whitespace' do
    hash = {'contains whitespace' => 'like that'}
    ha = hash.to_hash_accessor

    ha.contains_whitespace.should eq(nil)
  end

  it 'should work with string keys' do
    hash = {'something' => 'like that', 'name' => 'hash_ninja'}
    ha = hash.to_hash_accessor

    ha.something.should eq('like that')
    ha.name.should eq('hash_ninja')
  end

  it 'should work with array' do
    hash = {
        'str_array' => ['a', 'b', 'c'],
        'hash_array' => [{:a => 1}, {:aa => 1, :bb => 2}],
        'nested' => {'array' => [1, 2, 3]}
    }
    ha = hash.to_hash_accessor

    ha.str_array.should eq(['a', 'b', 'c'])
    ha.hash_array.should eq([{:a => 1}, {:aa => 1, :bb => 2}])
    ha.nested.array.should eq([1, 2, 3])
  end

end