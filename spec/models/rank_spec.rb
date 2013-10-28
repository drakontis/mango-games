require "spec_helper"

describe Rank do
  context "Validations" do
    it { should validate_presence_of :code }
  end

  context "Associations" do
    it { should have_many :users }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :code }
    it { should allow_mass_assignment_of :name }
  end
end