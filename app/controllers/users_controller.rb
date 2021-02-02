class UsersController < ApplicationController
  before_action :authenticate_user!
 before_action:correct,only: [:edit]
  
  def index
    @users = User.all
    @user =current_user
    @book = Book.new
  end
  

  def show
    @user = User.find(params[:id])
    @user_books = @user.books
    @book = Book.new
  end

  def edit
   
  end
  
  def update
    @book = Book.new
    @users = User.all
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="successfully updated"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  def correct
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
