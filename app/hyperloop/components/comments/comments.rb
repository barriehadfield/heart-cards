class Comments < Hyperloop::Component
  param :report

  render(DIV) do
    BR()
    params.report.comments.each do |comment|
      CommentLine(comment: comment)
      BR()
    end
    NewComment(report: params.report)

  end

  class CommentLine < Hyperloop::Component
    param :comment

    render(DIV) do
      LI { params.comment.body }
    end
  end

end
