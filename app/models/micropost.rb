# == Schema Information
# Schema version: 20110627234746
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
                                            
  validates :user_id,       :presence   => true
  validates :content,       :presence   => true,
                            :length     => {:maximum => 140}
   
  default_scope :order => 'microposts.created_at DESC'                         
  
  # Return microposts from the users being followed by the given user.
  #scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  def self.from_users_followed_by(user)
    followed_ids = user.following.map(&:id).join(", ")
    if followed_ids.blank?
      query = "user_id = :user_id"
    else
      query = "user_id IN (#{followed_ids}) OR user_id = :user_id"
    end
    where(query, { :user_id => user})
  end

  private
  
    # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
             { :user_id => user })
    end
end
