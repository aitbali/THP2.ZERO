    class Lesson < ApplicationRecord
        validates :title, presence: true, length: { maximum: 50 }
        validates :description, length: { maximum: 300 }
    end

