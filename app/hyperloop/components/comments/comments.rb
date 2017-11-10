class Comments < Hyperloop::Component
  param :report

  render(DIV) do
    BR()
    Sem.CommentGroup(minimal: true) {
      Sem.Header( as: 'h3', dividing: true ) { 'Comments' }
      params.report.comments.each do |comment|
        comment_item comment
      end
    }
    NewComment(report: params.report)
  end

  def comment_item comment
    DIV(class: 'ui minimal comment') {
      Sem.CommentContent {
        Sem.CommentAuthor {
          SPAN { comment.created_by.full_name }
          Sem.CommentMetadata { "today" }
        }
        Sem.CommentText { comment.body }
      }
    }
  end

end
