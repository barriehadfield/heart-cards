class HeartCard < Hyperloop::Component

  param :heart

  before_mount do
    mutate.show_settings false
  end

  render(DIV) do
    Sem.Card(fluid: true) {
      Sem.CardContent {
        Sem.CardHeader { header }
        Sem.CardContent { content }
      }
    }
    .on(:mouse_enter) { mutate.show_settings true }
    .on(:mouse_leave) { mutate.show_settings false }
  end

  def header
    Sem.Grid {
      Sem.GridRow(columns: 2) {
        Sem.GridColumn(width: 15) {
          P { params.heart.name }
          BR()
        }
        Sem.GridColumn(width: 1) { HeartModal(heart: params.heart, mode: :edit) } if state.show_settings
      }
    }
  end

  def content
    Categories(heart: params.heart, edit_mode: false)
  end

end
