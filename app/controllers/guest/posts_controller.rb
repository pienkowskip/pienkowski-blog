class Guest::PostsController < Guest::AbstractController
  def index
    @posts = Post.includes(:author).order(created_at: :desc).load
  end

  def show
    @post = Post.find(params[:id])
  end
end
