class HeartModal < Hyperloop::Component

  param :heart
  param :trigger

  render(DIV) do
    Sem.Modal(trigger: params.trigger.to_n) {
      Sem.ModalHeader { "Heart Card" }
      Sem.ModalContent {
        # Sem.ModalDescription {
          P {"modal body"}
        # }
      }
    }
  end
end
