class SecurityController < ApplicationController

  def self.has_permission(user, action)
    user_profile = User.find_by_id(user)
    sql="SELECT * FROM permissions(" + user_profile.profile_id.to_s + ", '" + action + "')"
    permission = ActiveRecord::Base.connection.execute(sql)
    
    if permission[0]["permission"] == "1"
      return true
    else
      return false
    end
    
  end
  
end
