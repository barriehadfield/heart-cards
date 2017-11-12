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
    SPAN {
      SPAN { "Report by #{params.report.member.full_name} " }
      TimeAgo(date: params.report.updated_at)
    }
  end

  def panel
    DIV { params.report.body }
  end

end
