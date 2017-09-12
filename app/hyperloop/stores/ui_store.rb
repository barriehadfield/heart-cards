class UiStore < Hyperloop::Store
  state :filter, reader: true, scope: :class

  def self.set_filter filter
    mutate.filter filter
  end

end
