FactoryBot.define do
  factory :lesson do
    title { Faker::GameOfThrones.character.first(50) }
    description { Faker::GameOfThrones.quote.first(300) }
  end
end
