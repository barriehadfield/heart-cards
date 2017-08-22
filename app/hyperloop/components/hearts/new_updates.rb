class NewUpdate < Hyperloop::Component
  param :heart
  param :category

  state open: false

  render(DIV) do
    if state.open
      new_update
    else
      Sem.Button(size: :mini) { "New Update" }.on(:click) {
        @update = Update.new
        mutate.open true
      }
    end
  end

  def new_update
    Sem.Form {
      Sem.TextArea(value: @update.body.to_s, placeholder: "Your update please", autoHeight: true)
      .on(:change) do |e|
        @update.body = e.target.value
      end
    }
    BR()
    Sem.Button(size: :mini, primary: true) { "Save" }.on(:click) {
      save
    }
    Sem.Button(size: :mini) { "Cancel" }.on(:click) {
      cancel
    }
    Sem.Divider(hidden: true)
  end

  def cancel
    mutate.open false
  end

  def save
    SaveUpdateOp.run(update: @update, heart: params.heart, category: params.category).then do |result|
      if result[:success]
        mutate.open false
      else
        alert "Unable to save Update"
      end
    end
  end

end
