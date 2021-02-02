class BooksController < ApplicationController
  
 before_action:correct,only:[:edit]
 
  def index
    @new_book = Book.new
    @books = Book.all
    @user = current_user
    @favorite = Favorite.new
  end
  
  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have creatad book successfully."
     redirect_to book_path(@book)
    else
      flash[:notice] = "can't be blank"
      @user = User.find(current_user.id)
      @books = Book.all.order(create_at: :desc)
      render "index"
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = User.find_by(id: @book.user_id)
    @favorite = Favorite.new
    @comment = BookComment.new
    @comments = @book.book_comments
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
     flash[:notice]="successfully updated"
     redirect_to book_path(@book)
    else
      flash[:notice]="updating error"
      render "edit"
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  def correct
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
  
 private
  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end
end
