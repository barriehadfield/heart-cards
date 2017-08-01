class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '5em' }) {
      Sem.Divider(horizontal: true) { "Or" }
      Sem.Button(primary: true) {"Click me"}
      heading
    }
  end

  def heading
    H1 { "Heart Cards here we come" }
  end

end
