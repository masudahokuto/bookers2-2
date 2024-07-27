class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    #送られてきた特定のidを持つユーザをUserモデルから取得し、@userに代入して表示出来るようにする
    @user = User.find(params[:id])
    #@userとhas_many(ｱｿｼｴｰｼｮﾝ)で関連付けられた.books(本)を@booksに代入して表示できるようにする
    @users = User.all
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
      return
    end
  end

  private

  def user_params
    #送られてきたデータがuserテーブルのnameとintroductionであるかの判断
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
