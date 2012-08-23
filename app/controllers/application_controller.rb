class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :markdown

private
  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    md.render(text).html_safe
  end

end
