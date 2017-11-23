class ReportCard < Hyperloop::Component
  param :report

  render(DIV) do
    title
    panel
    comments
  end

  def title
    Sem.CommentGroup(size: :huge) {
      DIV(class: 'ui minimal comment') {
        Sem.CommentAvatar(src: `Gravtastic(#{params.report.member.email.to_s})`  )
        Sem.CommentContent {
          Sem.CommentAuthor {
            DIV { params.report.member.full_name }
            Sem.HeaderSubheader { TimeAgo(date: params.report.member.updated_at) }
          }
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
