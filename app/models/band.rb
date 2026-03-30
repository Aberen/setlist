class Band < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  has_many :invitations, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :setlists, dependent: :destroy

  validates :name, presence: true

  def member?(user)
    members.include?(user)
  end

  def owner?(user)
    owner == user
  end
end
