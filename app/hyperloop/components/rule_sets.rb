class RuleSets < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '5em' }) {
      heading
    }
  end

  def heading
    H1 { "Rule Sets" }
  end

end
