# -*- encoding: utf-8 -*-

require "hash_ninja"

describe HashNinja::HashAttrReader do

  it 'should work with string keys' do
    hash = {:something => 'like that', :name => 'hash_ninja'}
    hash_attr = hash.to_attr_reader

    hash_attr.something.should eq('like that')
    hash_attr.name.should eq('hash_ninja')
  end

  it 'should work with symbol keys' do
    hash = {:something => 'like that', :name => 'hash_ninja'}
    hash_attr = hash.to_attr_reader

    hash_attr.something.should eq('like that')
    hash_attr.name.should eq('hash_ninja')
  end

  it 'should work with nested hash' do
    hash = {
        :something => 'like that',
        :nested => {
            :name => 'hash_ninja',
            :since => 2012
        }
    }
    hash_attr = hash.to_attr_reader

    hash_attr.something.should eq('like that')
    hash_attr.nested.name.should eq('hash_ninja')
    hash_attr.nested.since.should eq(2012)
  end

  it 'should work with keys which contains whitespace' do
    hash = {'contains whitespace' => 'like that'}
    hash_attr = hash.to_attr_reader

    hash_attr.contains_whitespace.should eq(nil)
  end

  it 'should work with string keys' do
    hash = {'something' => 'like that', 'name' => 'hash_ninja'}
    hash_attr = hash.to_attr_reader

    hash_attr.something.should eq('like that')
    hash_attr.name.should eq('hash_ninja')
  end

  it 'should work with array' do
    hash = {
        'str_array' => ['a', 'b', 'c'],
        'hash_array' => [{:a => 1}, {:aa => 1, :bb => 2}],
        'nested' => {'array' => [1, 2, 3]}
    }
    hash_attr = hash.to_attr_reader

    hash_attr.str_array.should eq(['a', 'b', 'c'])
    hash_attr.hash_array.should eq([{:a => 1}, {:aa => 1, :bb => 2}])
    hash_attr.nested.array.should eq([1, 2, 3])
  end

end