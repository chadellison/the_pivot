class SessionsRouter

  def self.referer_login?(session)
    File.basename(session) == "login"
  end

  def self.find_user(username)
    User.find_by(username: username)
  end

end
