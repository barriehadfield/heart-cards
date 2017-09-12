class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '2em' }) {
      # Sem.Grid {
      #   Sem.GridRow {
      #     Sem.GridColumn {
      #       new_heart
      #     }
      #   }
      #   heart_cards
      # }
    }
  end

  # def new_heart
  #   HeartModal(heart: Heart.new, mode: :new)
  # end

  # def heart_cards
  #
  #   Heart.reverse.each do |heart|
  #     Sem.GridRow {
  #       Sem.GridColumn {
  #         HeartCard(heart: heart)
  #       }
  #     }
  #   end
  # end
end
