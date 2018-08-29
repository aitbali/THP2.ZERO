# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { "#{Faker::Name.first_name}##{Random.rand(10_000)}" }
    password { Faker::Internet.password }
    provider "email"
    uid "123"

    trait :confirmed do
      confirmed_at { 2.days.ago }
    end

    trait :with_lessons do
      after(:create) do |user|
        create_list(:lesson, Random.rand(1..4), creator: user)
      end
    end
  end
end
