class SaveCommentOp < Hyperloop::Operation
  param :report
  param :comment

  step do
    params.comment.created_by = Member.current
    params.comment.report = params.report
    params.comment.save.then
  end

end
