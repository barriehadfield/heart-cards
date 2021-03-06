class Reports < Hyperloop::Component
  param :heart
  param :category

  render(DIV) do
    BR()
    Report.for_heart_category(params.heart.id, params.category).reverse.each do |report|
      # Sem.Header( as: 'h2', dividing: true ) { 'Report' }
      ReportCard(report: report)

    end
  end
end
