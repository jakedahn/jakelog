class Post < ActiveRecord::Base
  attr_accessible :cached_body, :current_version, :raw_body, :title
end
