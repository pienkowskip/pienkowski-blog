class Guest::PostsController < Guest::AbstractController
  helper_method :category_text_id

  def index
    @posts = Post.for_category(category_text_id).includes(:author).order(created_at: :desc).load
  end

  def show
    @post = Post.for_category(category_text_id).find(params[:id])
    redirect_to guest_post_url(@post, @post.title.parameterize) if params[:title] != @post.title.parameterize
  end

  private

  def category_text_id
    params[:category_text_id]
  end

  def default_url_options
    {category_text_id: category_text_id}
  end
end
