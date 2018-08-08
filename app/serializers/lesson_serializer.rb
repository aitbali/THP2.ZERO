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

class LessonSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at
end
