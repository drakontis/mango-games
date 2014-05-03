require "spec_helper"

describe Game do
  context "Validations" do
    it { should validate_presence_of :title        }
    it { should validate_presence_of :description  }
    it { should validate_presence_of :user_id      }
    it { should validate_presence_of :instructions }
  end

  context "Associations" do
    it { should have_and_belong_to_many :categories }
    it { should belong_to :user                     }
    it { should have_many :comments                 }
    it { should have_many :images                   }
    it { should have_many :ratings                  }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :title        }
    it { should allow_mass_assignment_of :description  }
    it { should allow_mass_assignment_of :approved     }
    it { should allow_mass_assignment_of :user         }
    it { should allow_mass_assignment_of :category_ids }
    it { should allow_mass_assignment_of :instructions }
  end
end