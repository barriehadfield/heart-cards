class PageLayout < Hyperloop::Router::Component

  render(DIV) do
    # H1 { "ready" }
    Sem.SidebarPushable(as: :Segment) {
      Sem.Sidebar(animation: :push, width: 'wide', visible: true, icon: :labeled) {
        side
      }
      Sem.SidebarPusher(as: :div) {
        body
      }
    }
  end

  def side
    Sem.Segment(basic: true) {
      new_heart
      filter_buttons
      100.times { P { 'on plane' } }
    }
  end

  def filter_buttons
    Filters()
  end

  def body
    Sem.Segment(basic: true) {
      Sem.Grid {
        heart_cards
      }
    }
  end

  def new_heart
    HeartModal(heart: Heart.new, mode: :new)
  end

  def heart_cards
    Heart.reverse.each do |heart|
      Sem.GridRow {
        Sem.GridColumn {
          HeartCard(heart: heart)
        }
      }
    end
  end


end
