class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '5em' }) {
      IMG(src: 'images/bench.jpg', height: 200)
      Sem.Divider(horizontal: true) { "Or" }
      Sem.Button(primary: true) {"Click me"}
      heading
    }
  end

  def heading
    H1 { "home with alfie" }
  end

end
