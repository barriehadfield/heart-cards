class MainAppBar < Hyperloop::Router::Component

  render(DIV) do
    Sem.Menu(borderless: true, color: :blue, inverted: true, size: :huge) {
      Sem.Container {
        Sem.MenuItem { heart_cards }
        Sem.MenuItem { members }
      }
    }
  end

  def heart_cards
    NavLink("/", class: "navlink", active_class: 'active') { "HEART CARDS" }
  end

  def members
    NavLink("/members", class: "navlink", active_class: 'active') { "MEMBERS" }
  end
end
