class LikesController < ActionController::Base
  respond_to :json
  before_filter :validate_user_and_params, :only => [:show, :create, :update]

  def index
    like_ids = 
      if current_user
         Like.select(:speech_id).where(:user_id => current_user.id, :status => true).to_a.map(&:speech_id)
      else
        []
      end
    render :json => like_ids
  end

  def show
    if like = current_user.like_speech(@speech)
      render :json => {:message => "ok", :status => like.status}, :success => true, :status => :ok
    else
      render :json => {:message => ""}, :success => false, :status => '302'
    end
  end

  def create
    if current_user.like_speech(@speech)
      render :json => {:message => ""}, :success => false, :status => '302'
    else
      like = current_user.likes.new(:speech_id => @speech.id,
                                    :status => true)
      if like.save
        render :json => {:message => "ok"}, :success => true, :status => :ok
      else
        render :json => {:message => "Error"}, :success => false, :status => :error
      end
    end
  end

  def update
    if like = current_user.like_speech(@speech)
      like.status = like.status ? false : true
      if like.save
        render :json => {:message => "ok", :status => like.status}, :success => true, :status => :ok
      else
        render :json => {:message => "Error"}, :success => false, :status => :error
      end
    end
  end

  private
  def validate_user_and_params
    unless current_user && params[:id] && @speech = Speech.find_by_permalink(params[:id])
      render :json => {:message => "Errors with validate options"}, :success => false, :status => '401'   # not Authorized
    end
  end
end
