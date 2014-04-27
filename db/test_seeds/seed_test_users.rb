puts 'seeding Users...'

users = [
    ['nim', '1234', 'nim@mangogames.com', Rank.first]
]

users.each do |username, password, email, rank|
  user = User.where(:username => username).first_or_create

  if user.new_record?
    user.username = username
    user.password = password
    user.email = email
    user.rank = rank
    user.save!
  end
end

puts '...end of seeding Users'
