class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '2em' }) {
      Sem.Grid {
        Sem.GridRow {
          Sem.GridColumn {
            new_heart
          }
        }
        heart_cards
      }
    }
  end

  def new_heart
    button = Sem.Button(icon: true, labelPosition: 'left') {
      Sem.Icon(name: :heart)
      "New Heart Card"
    }.as_node

    HeartModal(heart: Heart.new, trigger: button)
  end

  def heart_cards
    Heart.each do |heart|
      Sem.GridRow {
        Sem.GridColumn {
          HeartCard(heart: heart)
        }
      }
    end
  end

end
