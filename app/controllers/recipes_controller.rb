class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create]

  # GET /recipes or /recipes.json
  def index
    @q = Recipe.ransack(params[:q])
      if params[:tag_id].present?
        @recipes = Recipe.with_tag(params[:tag_id])
      else
        @recipes = @q.result
      end
    @tags = Tag.all
  end

  def look
    @tags = Tag.all
    @q = Recipe.ransack(params[:q])
  end

  def search
    @recipes = Recipe.where("title like ?", "%#{params[:q]}%")
    render partial: "recipes/search", locals: { recipes: @recipes }
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user).order(created_at: :desc)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.instructions.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.remote_image_url = retouch_image(params[:recipe][:image])

    respond_to do |format|
      if @recipe.save
        if params[:recipe][:tag_id].present?
          RecipeTag.create(recipe_id: @recipe.id, tag_id: params[:recipe][:tag_id])
        end
        format.html { redirect_to @recipe, notice: "レシピを作成しました。" }
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
        @recipe.recipe_tags.destroy_all
        if params[:recipe][:tag_id].present?
          RecipeTag.create(recipe_id: @recipe.id, tag_id: params[:recipe][:tag_id])
        end

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
      format.html { redirect_to recipes_path, status: :see_other, notice: "レシピの削除に成功しました。" }
      format.json { head :no_content }
    end
  end

  def favorites
    @favorite_recipes = current_user.favorite_recipes.includes(:user).order(created_at: :desc)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :trick, :get_point, :image, :image_cache, tag_id: [], ingredients_attributes: [ :id, :name, :quantity, :_destroy ], instructions_attributes: [ :id, :step, :content, :_destroy ])
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
