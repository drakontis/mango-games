require "spec_helper"

describe User do
  context "Validations" do
    it { should validate_presence_of     :username }
    it { should validate_confirmation_of :password }
    it { should validate_presence_of     :email    }
    it { should validate_presence_of     :rank_id  }
  end

  context "Associations" do
    it { should belong_to :rank     }
    it { should have_many :games    }
    it { should have_many :comments }
    it { should have_many :images   }
    it { should have_many :ratings  }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :username              }
    it { should allow_mass_assignment_of :password              }
    it { should allow_mass_assignment_of :email                 }
    it { should allow_mass_assignment_of :rank_id               }
    it { should allow_mass_assignment_of :password_confirmation }
  end

  context 'Password' do
    it 'should generate a hashed password' do
      subject.password=('1234')
      subject.hashed_password.should_not eq '1234'
      subject.hashed_password.size.should eq 64
    end
  end

  context '#root?' do
    it 'should return true if username is root' do
      subject.username = 'root'
      subject.root?.should be_true
    end

    it 'should return true if username is Root' do
      subject.username = 'Root'
      subject.root?.should be_true
    end

    it 'should return false if username is neither Root nor root' do
      subject.username = 'foo'
      subject.root?.should be_false
    end
  end
end