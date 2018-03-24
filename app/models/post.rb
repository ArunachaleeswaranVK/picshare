class Post < ActiveRecord::Base
    
    validates :title, presence: true, length: { minimum: 3, maximum: 12 }
    
    has_many :likes , dependent: :destroy
    
    has_many :users ,through: :likes
end
