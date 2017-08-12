class HeartCard < Hyperloop::Component

  param :heart

  before_mount do
    mutate.show_settings false
  end

  render(DIV) do
    Sem.Card(fluid: true, color: :blue) {
      Sem.CardContent {
        Sem.CardHeader { header }
      }
      Sem.CardContent { content }
      Sem.CardContent(extra: true) { footer }
    }
    .on(:mouse_enter) { mutate.show_settings true }
    .on(:mouse_leave) { mutate.show_settings false }
  end

  def header
    Sem.Grid {
      Sem.GridRow(columns: 2) {
        Sem.GridColumn(width: 15) {
          Sem.Header(as: :h2) {
            Sem.Icon(name: :heart, color: :blue)
            Sem.HeaderContent {
              SPAN { " #{params.heart.name}" }
              Sem.HeaderSubheader { "Updated 2 days ago" }
            }
          }
        }
        Sem.GridColumn(width: 1) { HeartModal(heart: params.heart, mode: :edit) } if state.show_settings
      }
    }
  end

  def content
    Categories(heart: params.heart, edit_mode: false)
  end

  def footer
    "Ceated by Ben Ridgeway 10 days ago"
  end

end
