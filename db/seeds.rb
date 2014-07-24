# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.all.each do |c| 
	 c.destroy 
end

categories = Category.create([ { name: 'Afghan' }, { name: 'Brazilian' }, { name: 'Korean' }, { name: 'Japanese' }, { name: 'Indian' }, 
		{ name: 'French' }, { name: 'Thai' }, { name: 'Chinese' }, { name: 'Vietnamese' }, { name: 'Italian' } ])
