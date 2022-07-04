class CommentsController < ApplicationController
  before_action :set_story
  before_action :authenticate_user!

  def new
  end
  

  def create
    @comment = @story.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to edit_story_path(@story), notice: "Comment was successfully created." }
      else
        format.html {  redirect_to edit_story_path(@story), status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :story_id)
  end
  def set_story
    @story = Story.find(params[:story_id])
  end
end
