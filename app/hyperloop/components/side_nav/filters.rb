class Filters < Hyperloop::Component

  render(DIV) do
    Sem.ButtonGroup {
      Sem.Button(active: (UiStore.filter == :draft)) { 'Draft' }
      .on(:click) { UiStore.set_filter :draft }
      Sem.Button(active: (UiStore.filter == :live)) { 'Live' }
      .on(:click) { UiStore.set_filter :live }
      Sem.Button(active: (UiStore.filter == :sleeping)) { 'Sleeping' }
      .on(:click) { UiStore.set_filter :sleeping }
    }
  end
end
