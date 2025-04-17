class Reward < ApplicationRecord
  belongs_to :user
  validates :required_points, presence: true
  validates :content, presence: true
end
