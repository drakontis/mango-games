puts 'seeding test games...'

game = Game.new(:title => 'krifto', :description => 'perigrafi krifto', :approved => true, :user => User.first!)
game.save!

puts '...end of seeding test games'