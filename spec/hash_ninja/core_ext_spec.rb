# -*- encoding: utf-8 -*-

require 'hash_ninja'

describe Hash do

  it 'should have #activate!' do
    activated = {:first => 'aaa', 'second' => 'bbb'}.activate!
    activated.is_a?(HashNinja::ActiveHash).should eq(true)
  end

  class Member
    attr_accessor :id
    attr_accessor :name
    attr_accessor :age

    def initialize(id, name, age)
      @id = id
      @name = name
      @age = age
    end
  end

  class Member2Underscore
    attr_accessor :firstName
    attr_accessor :lastName

    def initialize(firstName, lastName)
      @firstName = firstName
      @lastName = lastName
    end
  end

  class Member2Camelize
    attr_accessor :first_name
    attr_accessor :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end
  end

  it 'shoud have from_attr' do
    andy = Member.new(123, 'Andy', 20)
    andy_hash = Hash.from_attr(andy)
    andy_hash[:id].should eq(123)
    andy_hash[:name].should eq('Andy')
    andy_hash[:age].should eq(20)

    brian = Member.new(123, 'Brian', nil)
    brian_hash = Hash.from_attr(brian)
    brian_hash[:id].should eq(123)
    brian_hash[:name].should eq('Brian')
    brian_hash[:age].should eq(nil)
  end

  it 'should have from_attr (underscore)' do
    m = Member2Underscore.new('Linus', 'Torvalds')
    hash = Hash.from_attr(m, :underscore)
    hash[:first_name].should eq('Linus')
    hash[:last_name].should eq('Torvalds')
  end

  it 'should have from_attr (camelize)' do
    m = Member2Camelize.new('Linus', 'Torvalds')
    hash = Hash.from_attr(m, :camelize)
    hash[:FirstName].should eq('Linus')
    hash[:LastName].should eq('Torvalds')
  end

  it 'should have from_attr (camelize_lower)' do
    m = Member2Camelize.new('Linus', 'Torvalds')
    hash = Hash.from_attr(m, :camelize_lower)
    hash[:firstName].should eq('Linus')
    hash[:lastName].should eq('Torvalds')
  end

  it 'should have from_attr (classify)' do
    m = Member2Camelize.new('Linus', 'Torvalds')
    hash = Hash.from_attr(m, :classify)
    hash[:FirstName].should eq('Linus')
    hash[:LastName].should eq('Torvalds')
  end

end
