require "spec_helper"

describe Category do
  context "Validations" do
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of :code }
  end

  context "Associations" do
    it { should have_and_belong_to_many :games }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :code }
    it { should allow_mass_assignment_of :name }
  end
end