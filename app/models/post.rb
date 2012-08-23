class Post < ActiveRecord::Base
  attr_accessible :cached_body, :current_version, :raw_body, :title

  def to_param
    if title
      "#{id}-#{title.parameterize}"
    else
      "#{id}-Untitled"
    end
    
  end

end
