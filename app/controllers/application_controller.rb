class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :markdown, :current_user

private

  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    md.render(text).html_safe
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
