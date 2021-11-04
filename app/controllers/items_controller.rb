class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      tags = Vision.get_image_data(@item.image)    
      tags.each do |tag|
        @item.tags.create(name: tag)
    end
      redirect_to items_path
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page]).reverse_order
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    @user = @item.user
  end

  def edit
    @item = Item.find(params[:id])
    @user = @item.user
    if @user.id == current_user.id

    else
    redirect_to items_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    flash[:notice]= 'You have updated book successfully.'
    redirect_to item_path(@item.id)
    else
    render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

   private

  def item_params
    params.require(:item).permit(:title, :image, :body)
  end
end
