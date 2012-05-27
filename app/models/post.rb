class Post < ActiveRecord::Base
  attr_accessible :cached_body, :current_version, :raw_body, :title

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
