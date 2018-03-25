module ApplicationHelper
    
    def post_user(p)
        User.find_by(id: p.user_id).user_name
    end
end
