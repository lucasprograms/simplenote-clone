class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_params)
    user = User.find_by(username: user_params[:username])
    return nil if user.nil?
    user.is_password?(user_params[:password]) ? user : nil
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    save!
    session_token
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end