class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :band

  ROLES = %w[owner member].freeze

  validates :role, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :band_id, message: 'is already a member of this band' }

  scope :owners,       -> { where(role: 'owner') }
  scope :members_only, -> { where(role: 'member') }
end
