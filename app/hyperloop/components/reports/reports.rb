class Reports < Hyperloop::Component
  param :heart
  param :category

  render(DIV) do
    BR()
    Report.for_heart_category(params.heart.id, params.category).reverse.each do |report|
      ReportCard(report: report)
      BR()
    end
  end
end

class ReportCard < Hyperloop::Component
  param :report

  render(DIV) do
    Sem.Card(fluid: true) {
      Sem.CardContent {
        ReportPanel(report: params.report)
      }
      Sem.CardContent(extra: true) {
        ReportTitle(report: params.report)
      }
    }
  end
end

class ReportTitle < Hyperloop::Component
  param :report
  render do
    SPAN {
      SPAN { "Report by #{params.report.member.full_name} " }
      TimeAgo(date: params.report.updated_at)
    }
  end
end

class ReportPanel < Hyperloop::Component
  param :report

  render do
    SPAN { params.report.body }
  end
end
