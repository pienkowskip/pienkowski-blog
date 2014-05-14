class Admin::PostsController < Admin::AbstractController
  def index
    @posts = Post.includes(:author).order(created_at: :desc)
    unless params[:category_id].nil?
      category = Category.find(params[:category_id])
      @posts = @posts.where(category: category)
    end
    @posts.load
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.parsed_content = @post.content
    @post.author = current_user
    if @post.save
      redirect_to admin_posts_url
    else
      render action: 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    input = post_params
    created_at = input.delete(:created_at)
    unless created_at.nil?
      created_at = Time.now if created_at.blank?
      input[:created_at] = created_at
    end
    if @post.update(input)
      redirect_to admin_posts_url
    else
      render action: 'edit'
    end
  end

  def destroy
    if Post.destroy(params[:id])
      redirect_to admin_posts_url, notice: t('.success')
    else
      redirect_to admin_posts_url, alert: t('.failure')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :created_at)
  end
end
