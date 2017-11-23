class NewReport < Hyperloop::Component
  param :heart
  param :category

  # before_mount do
  #   @report = Report.new
  # end

  render(DIV) do
    new_report if ReportStore.new_report_visible
  end

  def new_report
    Sem.Form {
      TrixEditor(
        initial_value: ReportStore.report.body.to_s,
        model: ReportStore.report,
        field: :body,
        placeholder: "Your report please (you can paste images)"
      )
    }
    BR()
    Sem.Button(size: :mini, primary: true) { "Save" }.on(:click) {
      save unless ReportStore.report.body.blank?
    }
    Sem.Button(size: :mini) { "Cancel" }.on(:click) {
      cancel
    }
    Sem.Divider(hidden: true)
  end

  def cancel
    ReportStore.set_new_report_visible false
  end

  def save
    SaveReportOp.run(report: ReportStore.report, heart: params.heart, category: params.category).then do |result|
      if result[:success]
        ReportStore.set_new_report_visible false
      else
        alert "Unable to save Report"
      end
    end
  end

end
