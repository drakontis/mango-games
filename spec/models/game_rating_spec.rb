require "spec_helper"

describe GameRating do
  context "Validations" do
    it { should validate_presence_of :score    }
    it { should validate_presence_of :user_id  }
    it { should validate_presence_of :game_id  }

    it 'should not create multiple ratings for same user and same game' do
      rating = GameRating.new(:score => '5', :user => User.first!, :game => Game.first!)
      rating.save!

      lambda do
        rating = GameRating.new(:score => '7', :user => User.first!, :game => Game.first!)
        rating.save
      end.should_not change { GameRating.count }
    end
  end

  context "Associations" do
    it { should belong_to :user }
    it { should belong_to :game }
  end

  context "Mass assignment" do
    it { should allow_mass_assignment_of :score }
    it { should allow_mass_assignment_of :user  }
    it { should allow_mass_assignment_of :game  }
  end
end