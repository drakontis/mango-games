require "spec_helper"

describe Game do
  context "Validations" do
    it { should validate_presence_of :title       }
    it { should validate_presence_of :description }
    it { should validate_presence_of :user_id     }
  end

  context "Associations" do
    it { should have_and_belong_to_many :categories }
    it { should belong_to :user                     }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :approved }
    it { should allow_mass_assignment_of :user }
    it { should allow_mass_assignment_of :category_ids }
  end
end