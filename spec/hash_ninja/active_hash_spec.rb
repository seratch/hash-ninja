# -*- encoding: utf-8 -*-

require 'active_support'
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

  it 'should parse a real world example' do
    google_plus_people_response = <<JSON
{
  "kind": "plus#person",
  "id": "118051310819094153327",
  "displayName": "Chirag Shah",
  "url": "https://plus.google.com/118051310819094153327",
  "image": {
    "url": "https://lh5.googleusercontent.com/-XnZDEoiF09Y/AAAAAAAAAAI/AAAAAAAAYCI/7fow4a2UTMU/photo.jpg"
  }
}
JSON

    hash = ActiveSupport::JSON.decode(google_plus_people_response)
    hash.activate!

    hash.recursively_underscore_keys!
    hash['kind'].should eq('plus#person')
    hash['id'].should eq('118051310819094153327')
    hash['display_name'].should eq('Chirag Shah')
    hash['url'].should eq('https://plus.google.com/118051310819094153327')
    hash['image']['url'].should eq('https://lh5.googleusercontent.com/-XnZDEoiF09Y/AAAAAAAAAAI/AAAAAAAAYCI/7fow4a2UTMU/photo.jpg')

    hash.recursively_symbolize_keys!
    hash[:kind].should eq('plus#person')
    hash[:id].should eq('118051310819094153327')
    hash[:display_name].should eq('Chirag Shah')
    hash[:url].should eq('https://plus.google.com/118051310819094153327')
    hash[:image][:url].should eq('https://lh5.googleusercontent.com/-XnZDEoiF09Y/AAAAAAAAAAI/AAAAAAAAYCI/7fow4a2UTMU/photo.jpg')

    hash_attr = hash.to_attr_reader
    hash_attr.kind.should eq('plus#person')
    hash_attr.id.should eq('118051310819094153327')
    hash_attr.display_name.should eq('Chirag Shah')
    hash_attr.url.should eq('https://plus.google.com/118051310819094153327')
    hash_attr.image.url.should eq('https://lh5.googleusercontent.com/-XnZDEoiF09Y/AAAAAAAAAAI/AAAAAAAAYCI/7fow4a2UTMU/photo.jpg')
  end

end