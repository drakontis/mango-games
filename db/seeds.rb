# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if Rails.env = 'test'
  $: << "#{Rails.root}/db/test_seeds"

  load 'seed_test_ranks.rb'
  load 'seed_test_users.rb'
  load 'seed_test_games.rb'
else
  $: << "#{Rails.root}/db/seeds"

  load 'seed_ranks.rb'
  load 'seed_users.rb'
end
