class HeartCard < Hyperloop::Component

  param :heart

  render(DIV) do
    Sem.Card(fluid: true) {
      Sem.CardContent {
        Sem.CardHeader { params.heart.name }
        Sem.CardContent { "and the content here and some more here" }
      }
    }
  end
end
