class Reports < Hyperloop::Component
  param :heart
  param :category

  render(DIV) do
    panels = []
    Report.for_heart_category(params.heart.id, params.category).reverse.each do |report|
      panels << { title: ReportTitle(report: report).as_node,
                  content: ReportPanel(report: report).as_node,
                  key: report.id.to_s
      }
    end

    Sem.Accordion(panels: panels.to_n, styled: false, fluid: true) if panels.any?
  end
end

class ReportTitle < Hyperloop::Component
  param :report
  render do
    SPAN {
      SPAN { "Report from #{params.report.member.full_name} " }
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
