class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
     @book = Book.find(params[:id])
     @user = @book.user
    # @user = User.find(params[:id])
    # @book = Book.find(params[:id])
  	# @book = @user.books.find(params[:id])

    @book_comment = BookComment.new
    @book_comments = BookComment.all

  end
  def index
    @book_comments = BookComment.all
    @user = current_user
    @book = Book.new
    # @booker = Book.find(params[:id])
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params)#Bookモデルのテーブルを使用しているのでbookコントローラで保存する。

    @book.user = current_user
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      @user = current_user
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user.id != current_user.id
    redirect_to books_path
    end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
