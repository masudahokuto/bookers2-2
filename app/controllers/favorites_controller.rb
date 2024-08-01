class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
    #findとfind_byの違い
    #1 返り値 前者は見つからなかった場合エラー 後者は見つからない場合nilを返す
    #2 引数の形式 前者は主キーのidを引数で指定
                 #後者は            ハッシュで指定(今回はbook_idカラムのbook.id)
    #3 レコードの取得方法 findはDB検索時に主キーインデックスを利用し高速で取得
                        #find_byは条件合致するレコードを取得するのでfindより低速
    #まとめ
    #主キーでレコードを取得するときはfind
    #主キー以外でレコードを取得するときはfind_by
      #find_byの注意点  find_byは一致する最初のレコードのみ取得なので
                    #複数のレコードを取得したい時はwhereメソッド使用しないとダメ

