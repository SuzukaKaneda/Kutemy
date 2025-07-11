class Comment < ApplicationRecord
    validates :content, presence: true, length: { maximum: 65_535 }

    belongs_to :user
    belongs_to :recipe
    has_many :notifications, dependent: :destroy
end
