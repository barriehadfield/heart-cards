class ReportCard < Hyperloop::Component
  param :report

  render(DIV) do
    Sem.Card(fluid: true) {
      Sem.CardContent {
        title
      }
      Sem.CardContent {
        panel
        Comments(report: params.report)
      }
    }
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

  # def title
  #   SPAN {
  #     SPAN { "Report by #{params.report.member.full_name} " }
  #     TimeAgo(date: params.report.updated_at)
  #   }
  # end

  def panel
    DIV { params.report.body }
  end

end
