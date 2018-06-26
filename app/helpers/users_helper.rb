module UsersHelper
  def choose_new_or_edit
    if action_name == 'new'
      "新規登録"
    elsif action_name == 'edit'
      "変更を保存"
    end
  end
end
