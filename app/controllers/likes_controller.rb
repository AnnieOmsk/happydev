class LikesController < ActionController::Base
  respond_to :json

  def index
    like_ids = 
      if current_user
         Like.select(:speech_id).where(:user_id => current_user.id).to_a.map(&:speech_id)
      else
        []
      end
    render :json => like_ids
  end

  def create
    if current_user && params[:id] && speech = Speech.find_by_permalink(params[:id])
      like = current_user.likes.new(:speech_id => speech.id,
                                    :status => true)
      if like.save
        render :json => {:message => "ok"}, :success => true, :status => :ok
      else
        render :json => {:message => "Error"}, :success => false, :status => :error
      end
    end
  end

  def update
    
  end

  def destroy
    # debugger; puts 1
  end
end
