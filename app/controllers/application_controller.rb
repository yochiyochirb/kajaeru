class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?

  private

  def current_user
    return nil unless session[:user_id]

    # NOTE 操作するリソースによって current_user の意味が変わるのはやめたほうがいいかも
    #      しれないような気がするが、具体的に「これは困りそう」といったケースが思い浮かばず、
    #      他のモデルやコントローラでの操作時にこのほうが自然な実装にできる気がしたので、
    #      こうして分岐させた。
    case controller_name
    when 'votes', 'members'
      Voter.find_by(member_id: session[:user_id])
    #when '結果'
    end
  end

  def signed_in?
    !!current_user
  end
end
