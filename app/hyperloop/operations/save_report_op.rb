class SaveReportOp < Hyperloop::Operation
  param :heart
  param :report
  param :category

  step { params.report.member = Member.current }
  step { params.report.heart = params.heart }
  step { params.report.category = params.category }
  step { params.report.save.then }
end
