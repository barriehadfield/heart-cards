class Category < Hyperloop::Component

  param :category
  param :name
  param :description
  param :heart
  param :edit_mode

  render(DIV) do
    Sem.Grid {
      Sem.GridRow {
        Sem.GridColumn {
          params.edit_mode ? check_box : heading
        }
      }
      Sem.GridRow {
        Sem.GridColumn {
          if params.edit_mode
            category_fields
          else
            category_tabs
          end
         }
      } if params.heart["#{params.category}_bool"]
    }
  end

  def heading
    H4 { params.name } if params.heart["#{params.category}_bool"]
  end

  def check_box
    Sem.Checkbox(toggle: true, label: params.name,
      checked: (params.heart["#{params.category}_bool"] ? true : false )
    ).on(:change) {
      params.heart["#{params.category}_bool"] = !params.heart["#{params.category}_bool"]
    }
  end

  def category_tabs
    # this is wotking with no errors
    # pane = Sem.TabPane(attached: false) { "I am a pain" }.as_node
    # panes = [ {menuItem: 'tab 1', render: -> { pane.to_n }  } ]
    # Sem.Tab(menu: {secondary: true, pointing: true }.to_n, panes: panes.to_n )

    pane_a = Sem.TabPane { P {params.heart.happiness_goals} }.as_node
    pane_b = Sem.TabPane { "I am the next pain" }.as_node
    panes = [ {menuItem: 'Goals', render: -> { pane_a.to_n }},
              {menuItem: 'Signals', render: -> { pane_b.to_n }}
    ]
    Sem.Tab(panes: panes.to_n )

    options = [
      { value: 'one', label: 'One' },
      { value: 'two', label: 'Two' }
    ]
    ReactSelect( name: "form-field-name", value: "one", options: options.to_n, onChange: lambda do |val| log_change(val) end)
    # end
  end

  def log_change
    alert "changes here"
  end

  def change
    alert "change"
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
