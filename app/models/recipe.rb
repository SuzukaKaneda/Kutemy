class Recipe < ApplicationRecord
  mount_uploader :image,  RecipeImageUploader

  belongs_to :user

  has_many :ingredients,  dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true,  reject_if: lambda { |attributes| attributes["name"].blank? }
  has_many :instructions,  dependent: :destroy
  accepts_nested_attributes_for :instructions, allow_destroy: true,  reject_if: lambda { |attributes| attributes["content"].blank? }

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_many :notifications, dependent: :destroy

  scope :with_tag, ->(tag_id) { joins(:recipe_tags).where(recipe_tags: { tag_id: tag_id }) }
  def self.ransackable_attributes(auth_object = nil)
    %w[title] # 検索可能な属性を指定
  end

  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recipe_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        recipe_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      recipe_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
