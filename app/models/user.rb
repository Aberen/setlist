class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :bands, through: :memberships
  has_many :owned_bands, class_name: 'Band', foreign_key: :owner_id, dependent: :destroy

  def member_of?(band)
    bands.include?(band)
  end
end
