class ReportCard < Hyperloop::Component
  param :report

  render(DIV) do
    Sem.CommentGroup(size: :large) {
      DIV(class: 'ui minimal comment') {
        Sem.CommentAvatar(src: `Gravtastic(#{params.report.member.email.to_s})`  )
        Sem.CommentContent {
          Sem.CommentAuthor {
            DIV { params.report.member.full_name }
            SPAN(class: 'metadata no_left_indent') { TimeAgo(date: params.report.member.updated_at) }
          }
        }
        Sem.CommentContent {
          # Sem.Divider(hidden: true)
          BR()
          panel
        }
        Sem.CommentContent {
          comments
        }
      }
    }
  end

  def comments
    Comments(report: params.report)
  end

  def panel
    DIV(class: 'trix-content', dangerously_set_inner_HTML: { __html: params.report.body })
  end

end
