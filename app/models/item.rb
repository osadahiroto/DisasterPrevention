class Item < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  # フォロー機能
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索機能
  def self.looks(searches, words)
    if searches == "perfect_match"
      @item = Item.where("title LIKE ?", "#{words}")
    else
      @item = Item.where("title LIKE ?", "%#{words}%")
    end
  end

end
