class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, length: { minimum: 1, maximum: 200 }

  def favorited_by?(user)     #favorited_by?はメソッド名　(user)は引数を受け取るオブジェクト
      #favoritesテーブルのuser_idカラムにuser.idがあればture なければfalseを返す いいねされているかの確認
    favorites.exists?(user_id: user.id)
  end
end
