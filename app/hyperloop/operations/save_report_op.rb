class SaveReportOp < Hyperloop::Operation
  param :heart
  param :report
  param :category

  step do
    params.report.member = Member.current
    params.report.heart = params.heart
    params.report.category = params.category
    params.report.save.then
  end
end
