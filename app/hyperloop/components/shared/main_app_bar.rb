class MainAppBar < Hyperloop::Router::Component

  render(DIV) do
    Sem.Menu(borderless: true, color: :grey, inverted: true, size: :small, vertical: false) {
      Sem.Container {
        Sem.MenuItem { heart_cards }
        Sem.MenuItem { members }
      }
    }
  end

  def heart_cards
    NavLink("/", class: "navlink", active_class: 'active') { Sem.Icon(name: :heart) }
  end

  def members
    NavLink("/members", class: "navlink", active_class: 'active') { Sem.Icon(name: :users) }
  end
end
