class Category < Hyperloop::Component

  param :category
  param :name
  param :description
  param :heart
  param :edit_mode

  render(DIV) do
    Sem.Grid {
      Sem.GridRow {
        Sem.GridColumn { check_box }
      }
      Sem.GridRow {
        Sem.GridColumn {
          category_fields
         }
      } if params.heart["#{params.category}_bool"]
    }
  end

  def check_box
    Sem.Checkbox(toggle: true, label: params.name,
      checked: (params.heart["#{params.category}_bool"] ? true : false )
    ).on(:change) {
      params.heart["#{params.category}_bool"] = !params.heart["#{params.category}_bool"]
    }
  end

  def category_fields
    P { "Goals" }
    Sem.Form {
      TextInplace(field: "#{params.category}_goals", model: params.heart, label: "Goals",
        placeholder: "What are you trying to achieve?", edit_mode: params.edit_mode)
    }
    BR()
    P { "Signals" }
    Sem.Form {
      TextInplace(field: "#{params.category}_signals", model: params.heart, label: "Signals",
        placeholder: "What signals do you expect to see?", edit_mode: params.edit_mode)
    }
    BR()
    P { "Metrics" }
    Sem.Form {
      TextInplace(field: "#{params.category}_metrics", model: params.heart, label: "Metrics",
        placeholder: "And how will you measure this?", edit_mode: params.edit_mode)
    }
  end

end
