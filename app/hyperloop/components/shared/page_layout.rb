class PageLayout < Hyperloop::Router::Component

  render(DIV) do
    # H1 { "ready" }
    Sem.SidebarPushable(as: :Segment) {
      Sem.Sidebar(animation: :push, width: 'wide',
      visible: true, icon: :labeled, vertical: true, inverted: true) {
        # Sem.MenuItem(name: :home) {
        #     Sem.Icon(name: :home) { 'Home' }
        # }
        Sem.Segment(basic: true) {
          100.times { P {  "Alfie" } }
        }
      }
      Sem.SidebarPusher {
        Sem.Segment(basic: true) {
          Sem.Header { "Hello" }
          100.times { P {  "Alfie sleeping" } }
        }
      }
    }
  end
end
