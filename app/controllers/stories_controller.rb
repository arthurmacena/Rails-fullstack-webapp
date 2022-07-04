class StoriesController < ApplicationController
  before_action :set_story, only: %i[ show edit update destroy draft for_review in_review pending approved published archived ]

  # GET /stories or /stories.json
  def index
    @selected_status = params[:status]
    @selected_user_id = params[:user_id]

    @stories = Story.all

    @status = @stories.collect { |s| [s.status_name, s.status] }
    @writers = User.where(role: 'writer').collect { |u| [u.name, u.id] }.sort

    @stories = @stories.where(status: @selected_status) if @selected_status.present?

    @stories = @stories.where('writer_id = ? OR reviewer_id = ?', @selected_user_id, @selected_user_id) if @selected_user_id.present?

    @stories_paged = @stories.page(params[:page]).per(7)
  end

  # GET /stories/new
  def new
    @story = Story.new(status: 0)
    authorize @story
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories or /stories.json
  def create
    @story = Story.new(story_params)
    authorize @story

    respond_to do |format|
      if @story.save
        format.html { redirect_to edit_story_path(@story), notice: "Story was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to edit_story_path(@story), notice: "Story was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url, notice: "Story was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def for_review
    update_story_status('for_review')
  end
  
  def in_review
    update_story_status('in_review')
  end

  def pending
    update_story_status('pending')
  end

  def approved
    update_story_status('approved')
  end
  
  def published
    update_story_status('published')
  end

  def archived
    @story.status = 'archived'
    respond_to do |format|
      if @story.discard
        format.html { redirect_to stories_path, notice: "Story was successfully archived." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

    def update_story_status(new_status)
      @story.status = new_status
      @story.skip_some_callbacks = true
      respond_to do |format|
        if @story.save
          format.html { redirect_to edit_story_path(@story), notice: "Story was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
      authorize @story
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:title, :content, :status, :writer_id, :reviewer_id)
    end
end
