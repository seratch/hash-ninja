# -*- encoding: utf-8 -*-

require 'hash_ninja'

describe HashNinja::ActiveHash do

  it 'should have #underscore_keys!' do
    hash = {:rubyOnRails => 'xxx', 'ProgrammingRuby' => {'RubyGems' => 'yyy'}}
    hash.activate!.underscore_keys!

    hash[:ruby_on_rails].should eq('xxx')
    hash['programming_ruby'].should eq({'RubyGems' => 'yyy'})
  end

  it 'should have #recursively_underscore_keys!' do
    hash = {:rubyOnRails => 'aaa', 'ProgrammingRuby' => {:RubyGems => 'bbb', 'rubyMine' => 'ccc'}}
    hash.activate!.recursively_underscore_keys!

    hash[:ruby_on_rails].should eq('aaa')
    hash['programming_ruby'].should eq({:ruby_gems => 'bbb', 'ruby_mine' => 'ccc'})
    hash['programming_ruby'][:ruby_gems].should eq('bbb')
    hash['programming_ruby']['ruby_mine'].should eq('ccc')
  end

end