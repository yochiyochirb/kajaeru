module VotesHelper
  def vote_show_title
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == 'votes' && %w(new edit).include?(path[:action])
      '投稿完了画面'
    else
      '投票詳細画面'
    end
  end
end
