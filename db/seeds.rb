require_relative 'couple_challenges_data'
require_relative 'individual_challenges_data'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
CoupleChallenge.destroy_all
IndividualChallenge.destroy_all

puts "Creating couple challenges..."
COUPLE_CHALLENGES.each do |challenge|
  CoupleChallenge.create!(challenge)
end

puts "Creating individual challenges..."
INDIVIDUAL_CHALLENGES.each do |challenge|
  IndividualChallenge.create!(challenge)
end

puts "Finished!"
