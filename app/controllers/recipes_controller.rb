class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.remote_image_url = retouch_image(params[:recipe][:image])

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "レシピの更新に成功しました。" }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, status: :see_other, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :trick, :get_point, :image, :image_cache)
    end

    def retouch_image(image)
      if image.blank?
        uploaded_image = Cloudinary::Uploader.upload(Rails.root.join("app/assets/images/no_image.png"),
        transformation: [ { width: 250, height: 300, crop: "fit", background: "white" } ])
      else
        uploaded_image = Cloudinary::Uploader.upload(image.tempfile.path,
        transformation: [ { width: 250, height: 300, crop: "fit", background: "white" } ])
      end
      uploaded_image["url"]
    end
end
