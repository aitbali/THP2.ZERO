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

class Lesson < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }
end
