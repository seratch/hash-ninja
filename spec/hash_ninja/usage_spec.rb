# -*- encoding: utf-8 -*-

require 'active_support'
require 'hash_ninja'

describe HashNinja do

  it 'should work with the Google+ API example data' do
    google_plus_api_example = <<JSON
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

    hash = ActiveSupport::JSON.decode(google_plus_api_example)
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