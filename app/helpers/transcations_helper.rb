module TranscationsHelper
  def user_options(current_logged_user)
    if current_logged_user.class.to_s.eql?('User')
      User.where.not(id: current_logged_user.id).pluck(:email, :id)
    else
      User.all.pluck(:email, :id)
    end
  end

  def team_options(current_logged_user)
    if current_logged_user.class.to_s.eql?('Team')
      Team.where.not(id: current_logged_user.id).pluck(:email, :id)
    else
      Team.all.pluck(:email, :id)
    end
  end

  def stock_options(current_logged_user)
    if current_logged_user.class.to_s.eql?('Stock')
      Stock.where.not(id: current_logged_user.id).pluck(:email, :id)
    else
      Stock.all.pluck(:email, :id)
    end
  end
end
