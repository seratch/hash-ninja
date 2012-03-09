# -*- encoding: utf-8 -*-

require 'hash_ninja'

describe HashNinja::ActiveHash do
  it 'should has #underscore_keys! (String keys)' do
    hash = {'somethingLikeThat' => 'aaa', 'YetAnotherSomething' => {'NestedKey' => 'ccc'}}
    hash.extend_active_hash!.underscore_keys!
    hash['something_like_that'].should eq('aaa')
    hash['yet_another_something'].should eq({'NestedKey' => 'ccc'})
  end
  it 'should has #underscore_keys! (Symbol keys)' do
    hash = {:somethingLikeThat => 'aaa', :YetAnotherSomething => {:NestedKey => 'ccc'}}
    hash.extend_active_hash!.underscore_keys!
    hash[:something_like_that].should eq('aaa')
    hash[:yet_another_something].should eq({:NestedKey => 'ccc'})
  end
  it 'should has #recursively_underscore_keys! (Symbol keys)' do
    hash = {:somethingLikeThat => 'aaa', :YetAnotherSomething => {:NestedKey => 'ccc'}}
    hash.extend_active_hash!.recursively_underscore_keys!
    hash[:something_like_that].should eq('aaa')
    hash[:yet_another_something].should eq({:nested_key => 'ccc'})
  end
  it 'should has #recursively_underscore_keys! (Symbol keys)' do
    hash = {
        :somethingLikeThat => 'aaa',
        :YetAnotherSomething => [{:NestedKey1 => 'ccc'}, {:NestedKey2 => 'ddd'}]
    }
    hash.extend_active_hash!.recursively_underscore_keys!
    hash[:something_like_that].should eq('aaa')
    hash[:yet_another_something].should eq([{:nested_key1 => 'ccc'}, {:nested_key2 => 'ddd'}])
  end
end