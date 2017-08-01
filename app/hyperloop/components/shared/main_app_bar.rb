class MainAppBar < Hyperloop::Router::Component

  render(DIV) do
    app_bar
  end

  def app_bar
    Sem.Menu(fixed: :top, borderless: true, color: :red, inverted: true, size: :huge) {
      Sem.Container {
        Sem.MenuItem { home }
        Sem.MenuItem { members }
      }
    }
  end

  def home
    NavLink("/", class: "navlink", active_class: 'active') { "HOME" }
  end

  def members
    NavLink("/members", class: "navlink", active_class: 'active') { "MEMBERS" }
  end

end
