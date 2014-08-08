require 'spec_helper'

describe Privilege do
  context 'Attributes' do
    it { should respond_to :model }
    it { should respond_to :model= }
    it { should respond_to :action }
    it { should respond_to :action=}
  end

  context 'Initialize' do
    it 'should initialize with hash attributes' do
      privilege = Privilege.new :model => 'Game', :action => 'a'
      privilege.model.should == 'Game'
      privilege.model_label.should == 'Game'
      privilege.action.should == 'a'
      privilege.privilege_label.should == 'Game / a'
    end
  end

  context 'All' do
    it 'should be an array of Privilege' do
      result = Privilege.all
      result.each do |r|
        r.should be_a Privilege
      end
    end
  end

  context 'Fetch' do
    it 'should call all' do
      Privilege.should_receive :all

      Privilege.fetch
    end
  end

  context 'Id' do
    it 'should respond to id' do
      privilege = Privilege.new :model => 'm', :model_label => 'ml', :action => 'a'
      privilege.id.should == "#{privilege.model}/#{privilege.action}"
    end
  end

  context 'Privilege label' do
    it 'should return the privilege label' do
      privilege = Privilege.new :model => 'Game', :action => 'update'
      privilege.privilege_label.should == 'Game / update'
    end

    it 'should allow to set the privilege label' do
      privilege = Privilege.new :model => 'Game', :action => 'update'
      privilege.privilege_label.should == 'Game / update'

      privilege.privilege_label = 'Category / destroy'
      privilege.model_label.should == 'Category'
      privilege.action.should == 'destroy'
      privilege.privilege_label.should == 'Category / destroy'
    end
  end

  context 'Model label' do
    it 'should return the label as return by ability' do
      privilege = Privilege.new :model => 'Game', :action => 'update'
      privilege.model_label.should == 'Game'
    end

    it 'should allow to set the model label' do
      privilege = Privilege.new :model => 'Game', :action => 'update'
      privilege.model_label.should == 'Game'

      privilege.model_label = 'Category'

      privilege.model.should == 'Category'
      privilege.model_label.should == 'Category'
    end
  end
end