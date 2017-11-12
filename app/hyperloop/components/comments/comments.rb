class Comments < Hyperloop::Component
  param :report

  render(DIV) do
    Sem.Divider(hidden: true)
    Sem.CommentGroup(minimal: true, size: :mini) {
      Sem.Header(as: 'h4' ) { 'Comments' }
      params.report.comments.each do |comment|
        comment_item comment
      end
    }
    NewComment(report: params.report)
  end

  def comment_item comment
    DIV(class: 'ui minimal comment') {
      Sem.CommentAvatar(src: `Gravtastic(#{comment.created_by.email.to_s})`  )
      Sem.CommentContent {
        Sem.CommentAuthor {
          SPAN { comment.created_by.full_name }
          Sem.CommentMetadata { TimeAgo(date: comment.updated_at) }
        }
        Sem.CommentText { comment.body }
      }
    }
  end

end
