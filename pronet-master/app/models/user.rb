# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string
#  permission_level :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  PERMISSION_LEVELS = ['basic', 'admin', 'super_admin']

  paginates_per 30

  validates :email, 
              presence: true, 
              uniqueness: true, # the DB has a unique index on it as well though.
              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :permission_level,
              inclusion: { in: PERMISSION_LEVELS, message: "%{value} is not a valid permission level", allow_nil: true }

  has_many :flows
  has_many :user_host_links
  has_many :hosts, through: :user_host_links

  before_create do
    self.permission_level ||= "basic"
  end

  def has_permission_level(level)
    index_of_permission(self.permission_level) >= index_of_permission(level.to_s)
  end

  protected

  def index_of_permission(permission)
    PERMISSION_LEVELS.index(permission)
  end
end
