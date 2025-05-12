class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [ :google_oauth2 ]
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  has_many :recipes,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :rewards,  dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def own?(object)
    id == object&.user_id
  end

  def favorite(recipe)
    favorite_recipes << recipe
  end

  def unfavorite(recipe)
    favorite_recipes.destroy(recipe)
  end

  def favorite?(recipe)
    favorite_recipes.include?(recipe)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
