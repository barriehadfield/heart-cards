class ReportCard < Hyperloop::Component
  param :report

  render(DIV) do
    Sem.Card(fluid: true) {
      Sem.CardContent {
        panel
      }
      Sem.CardContent(extra: true) {
        title
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
