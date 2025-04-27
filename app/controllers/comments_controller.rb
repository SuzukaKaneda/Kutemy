class CommentsController < ApplicationController
    def create
      comment = current_user.comments.build(comment_params)
      if comment.save
        redirect_to recipe_path(comment.recipe), success: "コメントを投稿しました。"
      else
        redirect_to recipe_path(comment.recipe), danger: "コメントを投稿できませんでした。"
      end
    end

    def destroy
        @comment = current_user.comments.find(params[:id])
        @comment.destroy!
        redirect_to recipe_path(@comment.recipe)
    end

    private
  
    def comment_params
      params.require(:comment).permit(:content).merge(recipe_id: params[:recipe_id])
    end
  end