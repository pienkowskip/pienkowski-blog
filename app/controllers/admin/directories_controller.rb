class Admin::DirectoriesController < Admin::AbstractController
  def index
    action
  end

  def create
    @directory = Directory.new(post_params)
    if @directory.save
      redirect_to admin_directories_url
    else
      action
      render action: 'index'
    end
  end

  private

  def action
    norm = ->(str) { I18n.transliterate(str.to_s) }
    @directories = Directory.sort_by_ancestry(Directory.order(:name)) { |a, b| norm[a.name].casecmp(norm[b.name]) }
    @counts = Resource.group(:directory_id).count
  end

  def post_params
    params.require(:directory).permit(:name, :parent_id)
  end
end
