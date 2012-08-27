class User < ActiveRecord::Base
	attr_accessible :email, :name, :provider, :token, :uid

  has_many :repositories
  has_many :entries
  has_many :debts

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.fetch("provider")
      user.uid = auth.fetch('uid')
      user.name = auth["info"].fetch("name")
      user.email = auth["info"].fetch("email")
      user.token = auth["credentials"].fetch("token")
    end
  end

  def github_connection
    Octokit::Client.new(:login => "me", :oauth_token => self.token, :api_version => 2)
  end

end
