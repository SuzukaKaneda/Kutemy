class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    @recipe = @comment.recipe
    @recipe.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  def edit
    @comment = Comment.find(params[:id])
    @recipe = @comment.recipe
  end

  def update
    @comment = Comment.find(params[:id])
    @recipe = @comment.recipe
    if @comment.update(comment_edit_params)
      # 更新成功時の処理
    else
      # 更新失敗時の処理
      puts @comment.errors.full_messages
    end
  end

    private

  def comment_params
    params.require(:comment).permit(:content).merge(recipe_id: params[:recipe_id])
  end

  def comment_edit_params
    params.require(:comment).permit(:content)
  end
end
