class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , except: [:index]

  # GET /posts
  # GET /posts.json
  def index
    
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end  
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
   
    obj = S3_BUCKET.objects[params[:file].original_filename]
    
    # Upload the file
    obj.write(
      file: params[:file],
      acl: :public_read
    )
    
    # Create an object for the upload
    @post = Post.new(
			url: obj.public_url,
			image_name: obj.key,
			title: params[:title],
			user_id: current_user.id,
			tag_list: params[:tag_list]
		)
    
    # Save the upload
    if @post.save
      redirect_to posts_path, success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  respond_to :js

  def like
    @user = current_user
    @post = Post.find(params[:id])
    @user.like!(@post)
  end
  
  def unlike
    @user = current_user
    @like = @user.likes.find_by_post_id(params[:id])
    @post = Post.find(params[:id])
    @like.destroy!
  end
  
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title,:tag_list)
    end
end
