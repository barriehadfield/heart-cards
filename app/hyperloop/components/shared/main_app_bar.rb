class MainAppBar < Hyperloop::Router::Component

  render(DIV) do
    app_bar
  end

  def app_bar
    Sem.Menu(fixed: :top, borderless: true, color: :red, inverted: true, size: :huge) {
      Sem.Container {
        Sem.MenuItem { home }
        Sem.MenuItem { exercises }
        Sem.MenuItem { muscle_groups }
        Sem.MenuItem { rule_set }
        Sem.MenuItem { members }
      }
    }
  end

  def home
    NavLink("/", class: "navlink", active_class: 'active') { "HOME" }
  end

  def exercises
    NavLink("/exercises", class: "navlink", active_class: 'active') { "EXERCISES" }
  end

  def muscle_groups
    NavLink("/muscle-groups", class: "navlink", active_class: 'active') { "MUSCLE GROUPS" }
  end

  def rule_set
    NavLink("/rule-sets", class: "navlink", active_class: 'active') { "RULE SETS" }
  end

  def members
    NavLink("/members", class: "navlink", active_class: 'active') { "MEMBERS" }
  end

end
