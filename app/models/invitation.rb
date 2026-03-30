class Invitation < ApplicationRecord
  belongs_to :band

  before_create :generate_token

  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'is not a valid email address' }

  scope :pending, -> { where(accepted_at: nil) }

  def accepted?
    accepted_at.present?
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(24)
  end
end
