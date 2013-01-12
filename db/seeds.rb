# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# Places

Place.create!([
  {
    :name               => "Café com Arte",
    :description        => "",
    :address            => "Avenida Elísio de Moura 367. 3030 - Portugal",
    :photo_urls         => [],
  },
    {
    :name               => "Galeria Bar Santa Clara",
    :description        => nil,
    :address            => "Rua António Augusto Gonçalves 67, 3040-241 Coimbra, Portugal",
    :photo_urls         => ["https://lh3.googleusercontent.com/-zu9hXZ05NGk/UCOIyvuRicI/AAAAAABQkYI/GGhSEOImjOE/w264-h198-n-k/Galeria%2BBar%2BSanta%2BClara", "https://lh6.googleusercontent.com/-xp_roK1YXro/UCOAFaKV8WI/AAAAAABQUoQ/atDaumhusm8/w265-h198-n-k/Galeria%2BBar%2BSanta%2BClara"],
  },
])
