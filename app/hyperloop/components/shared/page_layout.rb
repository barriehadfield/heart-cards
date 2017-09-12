class PageLayout < Hyperloop::Router::Component

  render(DIV) do
    # H1 { "ready" }
    Sem.SidebarPushable(as: :Segment) {
      Sem.Sidebar(animation: :push, width: 'wide', visible: true, icon: :labeled) {
        side
      }
      Sem.SidebarPusher {
        body
      }
    }
  end

  def side
    DIV {
      Sem.Segment(basic: true) {
        100.times { P {  "Alfie" } }
      }
    }
  end

  def body
    DIV(class: 'main-container') {
      Sem.Segment(basic: true) {
        Sem.Header { "Hello" }
        100.times { P {  "Alfie sleeping" } }
      }
    }
  end
end
