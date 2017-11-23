class ReportStore < Hyperloop::Store
  state new_report_visible: false, reader: true, scope: :class
  state :report, reader: true, scope: :class

  def self.set_new_report_visible v
    mutate.new_report_visible v
  end

  def self.create_new_report
    mutate.report Report.new
  end

end
