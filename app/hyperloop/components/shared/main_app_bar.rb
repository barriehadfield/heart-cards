class MainAppBar < Hyperloop::Router::Component

  render(DIV) do
    app_bar
  end

  def app_bar
    Sem.Menu(fixed: :top, borderless: true, color: :red, inverted: true, size: :huge) {
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
