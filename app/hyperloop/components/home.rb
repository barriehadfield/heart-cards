class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '5em' }) {
      new_card_button
      heart_cards
    }
  end

  def new_card_button
    Sem.Button { "New Heart Card" }
  end

  def heart_cards
    Heart.each do |heart|
      HeartItem(heart: heart)
      BR
    end
  end

end
