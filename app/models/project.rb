class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  attr_accessor :user_email_to_share_with
  has_many :project_shares
  has_many :users_shared_with, through: :project_shares, source: :user
end
