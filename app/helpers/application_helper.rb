module ApplicationHelper
    
    def post_user(p)
       @user =  User.find_by(id: p.user_id)
       unless @user.nil? 
            return @user 
        else
            return "Anonymous"
       end            
    end
end
