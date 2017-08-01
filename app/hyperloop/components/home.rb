class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '5em' }) {
      Sem.Grid {
        new_card_button
        heart_cards
      }
    }
  end

  def new_card_button
    Sem.GridRow {
      Sem.GridColumn {
        Sem.Button(icon: true, labelPosition: 'left') {
          Sem.Icon(name: :heart)
          "New Heart Card"
        }
      }
    }
  end

  def heart_cards
    Heart.each do |heart|
      Sem.GridRow {
        Sem.GridColumn {
          HeartItem(heart: heart)
        }
      }
    end
  end

end
