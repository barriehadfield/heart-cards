class HeartModal < Hyperloop::Component

  param :heart
  param :trigger

  render(DIV) do
    Sem.Modal(trigger: params.trigger.to_n) {
      Sem.ModalHeader {
        params.heart.name.nil? || params.heart.name.length == 0 ? "New Heart Card" : params.heart.name
      }
      Sem.ModalContent {
        content
      }
      Sem.ModalActions {
        actions
      }
    }
  end

  def content
    Sem.Input(placeholder: "Heart Card name", fluid: true, defaultValue: params.heart.name).on(:change) do |e|
      params.heart.name = e.target.value
    end
    H5 { "Please choose one or more categories from the HEART framework you would like to track" }
    Categories(heart: params.heart, edit: true)
  end

  def actions
    Sem.Button { "Close" }
  end

end
