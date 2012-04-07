# Hash-Ninja

Hash-Ninja is a Hash operations toolkit for Ruby Ninja.

https://rubygems.org/gems/hash-ninja


## Supported Ruby versions

Hash-Ninja runs on Ruby 1.9.2, 1.9.3.


## Gemfile

```
source "http://rubygems.org/"

gem 'hash-ninja'
```


## Usage

```ruby
require 'active_support'
require 'hash_ninja'

name = {'fullName' => {'firstName' => 'Linus', 'lastName' => 'Torvalds'}}
name['fullName']['firstName'].should eq('Linus')
name['fullName']['lastName'].should eq('Torvalds')

name.activate!
# => {"fullName"=>{"firstName"=>"Linus", "lastName"=>"Torvalds"}}

name.recursively_underscore_keys!
# => {"full_name"=>{"first_name"=>"Linus", "last_name"=>"Torvalds"}}
name['full_name']['first_name'].should eq('Linus')
name['full_name']['last_name'].should eq('Torvalds')

name.recursively_symbolize_keys!
# => {:full_name=>{:first_name=>"Linus", :last_name=>"Torvalds"}}
name[:full_name][:first_name].should eq('Linus')
name[:full_name][:last_name].should eq('Torvalds')

name_attr = name.to_attr_reader
# => #<HashNinja::HashAttrReader:0x007fa05387b748 @hash={:full_name=>{:first_name=>"Linus", :last_name=>"Torvalds"}}>
name_attr.full_name.first_name.should eq('Linus')
name_attr.full_name.last_name.should eq('Torvalds')
```

See specs in detail.

https://github.com/seratch/hash-ninja/blob/master/spec/hash_ninja/usage_spec.rb


## Build Status

[![Build Status](https://secure.travis-ci.org/seratch/hash-ninja.png)](http://travis-ci.org/seratch/hash-ninja)


## License

MIT License

https://github.com/seratch/hash-ninja/blob/master/LICENSE.txt


