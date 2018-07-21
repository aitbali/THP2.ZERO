# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :lesson do
    title { Faker::GameOfThrones.character.first(50) }
    description { Faker::GameOfThrones.quote.first(300) }
  end
end