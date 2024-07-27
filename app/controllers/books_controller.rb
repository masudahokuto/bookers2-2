class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update] 
  def index
    @book = Book.new                            #@book = Bookモデルの新しいインスタンス
    @user = User.all
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)               #誰かのtitleとbodyが含まれたbook
    @book.user_id = current_user.id             #bookテーブルのuser_idカラムにcurrent userのidを入れる

    if @book.save                               #もしbookの登録に成功したら
          #bookのshow画面に遷移します、且つ成功したというメッセージを表示します
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else                                        #bookの登録に成功しなかったら
      @books = Book.all                         #Bookモデルの情報を全て取得
      @user = User.find(current_user.id)        #Userモデル内のcurrent userのid情報を探し出し取得
      render 'index'                            #取得した情報を元にbookのindex画面を表示します
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def book_params
    #送られてきたデータがbookテーブルのtitleとbodyであるかの判断
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
