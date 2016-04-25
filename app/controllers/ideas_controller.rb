class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :find_idea, only: [:edit, :update, :destroy, :show]
  before_action :authorize_idea, only: [:edit, :update, :destroy]


  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "Idea created!"
      redirect_to idea_path(@idea)
    else
      flash[:alert] = "Idea didn't save!"
      render :new
    end
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea), notice: "Idea updated"
    else
      render :edit
    end
  end

  def show

  end

  private
  def idea_params
    params.require(:idea).permit(:title, :body);
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize_idea
    redirect_to idea_path(@idea) unless @idea.user_id = current_user.id
  end

end
