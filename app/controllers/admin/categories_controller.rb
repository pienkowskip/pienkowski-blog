class Admin::CategoriesController < Admin::AbstractController
  def index
    action
  end

  def edit
    @category = Category.find(params[:id])
    action
  end

  def create
    @category = Category.new(post_params)
    if @category.save
      redirect_to admin_categories_url
    else
      action
      render action: 'index'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(post_params)
      redirect_to admin_categories_url
    else
      action
      render action: 'edit'
    end
  end

  def destroy
    if Category.destroy(params[:id])
      redirect_to admin_categories_url, notice: t('.success')
    else
      redirect_to admin_categories_url, alert: t('.failure')
    end
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to admin_categories_url, alert: t('.dependent')
  end

  private

  def action
    @categories = Category.order(:text_id).load
    @counts = Post.group(:category_id).count
  end

  def post_params
    params.require(:category).permit(:name, :text_id)
  end
end
