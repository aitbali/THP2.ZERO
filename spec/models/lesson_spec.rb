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

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it "is creatable" do
    lesson = create(:lesson)
    expect(lesson.title).not_to be_blank
    expect(lesson.description).not_to be_blank
  end

  it "follows creator link" do
    lesson = create(:lesson).reload
    expect(lesson.creator.lessons.first).to eq(lesson)
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(50) }
  it { is_expected.to validate_length_of(:description).is_at_most(300) }
end
