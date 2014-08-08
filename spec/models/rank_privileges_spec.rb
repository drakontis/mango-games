require "spec_helper"

describe RankPrivilege do
  context "Validations" do
    it 'should have model' do
      ActiveModel::Validations::PresenceValidator.should be_attached RankPrivilege, :model
    end

    it 'should have a model with maximum length' do
      ActiveModel::Validations::LengthValidator.should be_attached RankPrivilege, :model, {:maximum => 64}
    end

    it 'should have action' do
      ActiveModel::Validations::PresenceValidator.should be_attached RankPrivilege, :action
    end

    it 'should have action with maximum length' do
      ActiveModel::Validations::LengthValidator.should be_attached RankPrivilege, :action, {:maximum => 32}
    end

    it 'should take an action form list' do
      rank_privilege = RankPrivilege.new :model => 'Game', :action => 'kou'

      rank_privilege.should have(1).error_on :action
      rank_privilege.errors[:action].should include 'not valid on this model'

      rank_privilege.action = 'create'
      rank_privilege.should have(0).errors_on :action
    end

    it 'should be able to create a rank privilege given the model label' do
      rank = Rank.last

      rank_privilege = RankPrivilege.new :model_label => 'Game', :action => 'create'
      rank_privilege.should be_valid

      rank.rank_privileges << rank_privilege

      rank.reload

      rank.rank_privileges.map{|rp| [rp.model, rp.model_label, rp.action]}.should include ['Game', 'Game', 'create']
    end

    it 'should be able to create a rank privilege with model all and action manage' do
      rank_privilege = RankPrivilege.new :model => 'all', :action => 'manage'
      rank_privilege.should be_valid
    end

    it 'should have unique action' do
      ActiveRecord::Validations::UniquenessValidator.should be_attached RankPrivilege, :action, :scope => [:rank_id, :model]
    end

    it 'should not be able to assign the same action model on the same rank for new rank privilege' do
      rank = Rank.new(:code => 44, :name => 'NewRank')
      rank.should be_valid

      rank.rank_privileges << RankPrivilege.new(:model => 'Game', :action => 'create')
      rank.should be_valid
      rank.save

      rank_privilege = RankPrivilege.new(:model => 'Game', :action => 'create', :rank_id => rank.id)
      rank_privilege.should have(1).error_on :action
      rank_privilege.errors[:action].should include 'has already been taken'
    end
  end

  context "Associations" do
    it { should belong_to :rank }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :rank_id     }
    it { should allow_mass_assignment_of :model       }
    it { should allow_mass_assignment_of :action      }
    it { should allow_mass_assignment_of :model_label }
  end

  context 'Other methods' do
    it 'should respond to model label' do
      rank_privilege = RankPrivilege.new :model => 'Game', :action => 'create'

      #fire
      rank_privilege.model_label.should == "Game"
    end

    it 'should set model label' do
      rank_privilege = RankPrivilege.new

      # fire
      rank_privilege.model_label = 'Game'

      rank_privilege.model_label.should == 'Game'
      rank_privilege.model.should == 'Game'
    end
  end

end