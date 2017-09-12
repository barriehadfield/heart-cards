class Filters < Hyperloop::Component
  state selected: :live

  render(DIV) do
    Sem.ButtonGroup {
      Sem.Button(active: (state.selected == :draft)) { 'Draft' }
      .on(:click) { mutate.selected :draft }
      Sem.Button(active: (state.selected == :live)) { 'Live' }
      .on(:click) { mutate.selected :live }
      Sem.Button(active: (state.selected == :sleeping)) { 'Sleeping' }
      .on(:click) { mutate.selected :sleeping }
    }
  end
end
