class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :user_name, presence: true, length: { minimum: 3, maximum: 16 } 
  
  has_many :likes, dependent: :destroy
  has_many :posts, through: :likes
  
  has_many :comments, dependent: :destroy
  
  def like!(post)
    self.likes.create!(post_id: post.id)
  end
  
  # destroys a heart with matching post_id and user_id
  def unlike!(post)
    heart = self.likes.find_by_post_id(post.id)
    heart.destroy!
  end
  
  # returns true of false if a post is hearted by user
  def like?(post)
    self.likes.find_by_post_id(post.id)
  end
end
