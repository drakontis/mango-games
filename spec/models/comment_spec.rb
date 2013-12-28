require "spec_helper"

describe Comment do
  context "Validations" do
    it { should validate_presence_of :body    }
    it { should validate_presence_of :game_id }
    it { should validate_presence_of :user_id }
  end

  context "Associations" do
    it { should belong_to :user }
    it { should belong_to :game }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :body }
    it { should allow_mass_assignment_of :user }
    it { should allow_mass_assignment_of :game }
  end
end