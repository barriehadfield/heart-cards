class NewReport < Hyperloop::Component
  param :heart
  param :category

  state open: false

  render(DIV) do
    if state.open
      new_report
    else
      Sem.Button(primary: true, size: :mini) { "New Report" }.on(:click) {
        @report = Report.new
        mutate.open true
      }
    end
  end

  def new_report
    Sem.Form {
      Sem.TextArea(value: @report.body.to_s, placeholder: "Your report please", autoHeight: true)
      .on(:change) do |e|
        @report.body = e.target.value
      end
    }
    BR()
    Sem.Button(size: :mini, primary: true) { "Save" }.on(:click) {
      save
    }
    Sem.Button(size: :mini) { "Cancel" }.on(:click) {
      cancel
    }
    Sem.Divider(hidden: true)
  end

  def cancel
    mutate.open false
  end

  def save
    SaveReportOp.run(report: @report, heart: params.heart, category: params.category).then do |result|
      if result[:success]
        mutate.open false
      else
        alert "Unable to save Report"
      end
    end
  end

end
