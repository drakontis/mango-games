require "spec_helper"

describe Rank do
  context "Validations" do
    it { should validate_presence_of :code   }
    it { should validate_uniqueness_of :code }
  end

  context "Associations" do
    it { should have_many :users }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :code                       }
    it { should allow_mass_assignment_of :name                       }
    it { should allow_mass_assignment_of :rank_privileges            }
    it { should allow_mass_assignment_of :rank_privileges_attributes }
  end
end