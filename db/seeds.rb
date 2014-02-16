# encoding: UTF-8

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
                      :visible            => true,
                      :latitude           => 40.212534,
                      :longitude          => -8.39735,
                      :sticker            => 2013
                  },
                  {
                      :name               => "Galeria Bar Santa Clara",
                      :description        => nil,
                      :address            => "Rua António Augusto Gonçalves 67, 3040-241 Coimbra, Portugal",
                      :photo_urls         => ["https://lh3.googleusercontent.com/-zu9hXZ05NGk/UCOIyvuRicI/AAAAAABQkYI/GGhSEOImjOE/w264-h198-n-k/Galeria%2BBar%2BSanta%2BClara", "https://lh6.googleusercontent.com/-xp_roK1YXro/UCOAFaKV8WI/AAAAAABQUoQ/atDaumhusm8/w265-h198-n-k/Galeria%2BBar%2BSanta%2BClara"],
                      :visible            => true,
                      :latitude           => 40.21285,
                      :longitude          => -8.397202
                      :sticker            => 2014
                  },
                  {
                      :name               => "Café e Cervejaria Samambaia",
                      :description        => nil,
                      :address            => "Praça Infante Dom Henrique, 3030-055 Coimbra, Portugal",
                      :photo_urls         => ["https://lh3.googleusercontent.com/-RPyVoMokc0M/UGFGNLeEBzI/AAAAAAAAAAY/JdBaDKa69OI/s711/2012-09-24"],
                      :visible            => true,
                      :latitude           => 40.2021,
                      :longitude          => -8.433509
                  },
                  {
                      :name               => "Restaurante Piazza",
                      :description        => nil,
                      :address            => "Praça da República 38, 3000-995 Coimbra, Portugal",
                      :photo_urls         => [],
                      :visible            => true,
                      :latitude           => 40.199156,
                      :longitude          => -8.411138
                  },
                  {
                      :name               => "Bar das piscinas da Quinta de São Jerónimo",
                      :description        => nil,
                      :address            => "Rua Edmundo Bettencourt 15, 3000-606 Coimbra, Portugal",
                      :photo_urls         => [],
                      :visible            => true,
                      :latitude           => 40.211474,
                      :longitude          => -8.405292
                  },
                  {
                      :name               => "Cafe São Paulo",
                      :description        => nil,
                      :address            => "Rua Casa Branca 38, 3030 Coimbra, Portugal",
                      :photo_urls         => [],
                      :visible            => true,
                      :latitude           => 40.211482,
                      :longitude          => -8.405288
                  },
                  {
                      :name               => "Bar Quebra Costas",
                      :description        => nil,
                      :address            => "Rua de Quebra Costas 45, 3000 Coimbra, Portugal",
                      :photo_urls         => [],
                      :visible            => true,
                      :latitude           => 40.209103,
                      :longitude          => -8.400271
                  }
              ])
