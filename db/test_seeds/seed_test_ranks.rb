puts 'seeding ranks...'

ranks = [
    [0, 'Banned'],
    [5, 'User'],
    [10, 'Super User'],
    [15, 'Moderator'],
    [20, 'Administrator']
]

ranks.each do |code, name|
  rank = Rank.where(:code => code).first_or_initialize

  if rank.new_record?
    rank.name = name
    rank.save
  end
end

puts '...end of seeding ranks'

#rank = Rank.first_or_create(:code => 0)
#if rank.new_record?
#  rank.name = 'Banned'
#  rank.save
#end
#
#rank = Rank.first_or_create(:code => 5)
#if rank.new_record?
#  rank.name = 'User'
#  rank.save
#end
#
#rank = Rank.first_or_create(:code => 10)
#if rank.new_record?
#  rank.name = 'Super User'
#  rank.save
#end
#
#rank = Rank.first_or_create(:code => 15)
#if rank.new_record?
#  rank.name = 'Moderator'
#  rank.save
#end
#
#rank = Rank.first_or_create(:code => 20)
#if rank.new_record?
#  rank.name = 'Administrator'
#  rank.save
#end