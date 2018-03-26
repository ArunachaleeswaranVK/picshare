class Post < ActiveRecord::Base
    
    validates :title, presence: true
    
    has_many :likes , dependent: :destroy
    
    has_many :users ,through: :likes
    
    has_many :comments, dependent: :destroy
    
    acts_as_taggable
    
    include SimpleRecommender::Recommendable
    similar_by :users
end
