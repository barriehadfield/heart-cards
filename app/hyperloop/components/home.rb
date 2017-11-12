class Home < Hyperloop::Router::Component

  render(DIV) do
    Sem.Segment(basic: true) {
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
    }
  end

  def new_heart
    HeartModal(heart: Heart.new, mode: :new)
  end

  def heart_cards
    hearts = Heart.active

    Sem.Dimmer(inverted: true, active: hearts.loading?) {
      Sem.Loader(content: 'Bending time and space')
    }

    hearts.each do |heart|
      Sem.GridRow {
        Sem.GridColumn {
          HeartCard(heart: heart)
        }
      }
    end
  end
end
