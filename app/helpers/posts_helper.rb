module PostsHelper
  def choose_url
    if action_name == 'new' || action_name == 'confirm'
      confirm_posts_path
    elsif action_name == 'edit'
      post_path
    end
  end
end
