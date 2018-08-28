# == Schema Information
#
# Table name: lessons
#
#  id          :uuid             not null, primary key
#  description :text
#  title       :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :uuid
#
# Indexes
#
#  index_lessons_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#

FactoryBot.define do
  factory :lesson do
    creator { create(:user) }

    title { Faker::GameOfThrones.character.first(50) }
    description { Faker::GameOfThrones.quote.first(300) }
  end
end
