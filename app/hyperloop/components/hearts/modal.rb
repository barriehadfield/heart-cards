class MyOp < Hyperloop::Operation
  step { puts "in the test op" }
end


class HeartModal < Hyperloop::Component

  param :heart
  param :mode

  render(DIV) do
    if state.open
      render_modal
    else
      edit_or_new_button.on(:click) { mutate.open true }
    end
  end

  def render_modal
    Sem.Modal(open: state.open) {
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

  def edit_or_new_button
    if params.mode == :new
      Sem.Button(icon: true, labelPosition: 'left', primary: true) {
        Sem.Icon(name: :heart)
        "New Heart Card"
      }
    else
      Sem.Button(circular: true, icon: :setting)
    end
  end

  def content
    P { "Please give this Heart Card a good clear name" }
    Sem.Input(placeholder: "Heart Card name", fluid: true, defaultValue: params.heart.name).on(:change) do |e|
      params.heart.name = e.target.value
    end
    BR()
    P { "Choose one or more categories from the HEART framework you would like to track" }
    Categories(heart: params.heart, edit_mode: true)
  end

  def actions
    Sem.Button(primary: true) { "Save" }.on(:click) { save } if params.heart.changed?
    Sem.Button { "Cancel" }.on(:click) { cancel }
  end

  def save
    SaveHeartOp.run(heart: params.heart).then do |result|
      if result[:success]
        mutate.open false
      else
        alert "Unable to save Heart Card"
      end
    end
  end

  def cancel
    params.heart.revert
    mutate.open false
  end


end
