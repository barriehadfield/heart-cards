class Category < Hyperloop::Component

  param :category
  param :name
  param :description
  param :edit
  param :heart

  render(DIV) do
    Sem.Grid {
      Sem.GridRow {
        Sem.GridColumn { check_box }
      }
    }
  end

  def check_box
    Sem.Checkbox(toggle: true, label: params.name,
      checked: params.heart["#{params.category}_bool"] ).on(:change) {
        params.heart["#{params.category}_bool"] = !params.heart["#{params.category}_bool"]
    }
  end

end
