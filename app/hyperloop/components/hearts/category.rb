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
    Sem.Header(as: :h2, color: :blue) {
      SPAN { params.name }
      Sem.HeaderSubheader { params.description }
      } if params.heart["#{params.category}_bool"]
  end

  def check_box
    Sem.Grid {
      Sem.GridRow {
        Sem.GridColumn {
          Sem.Checkbox(toggle: true, checked: (params.heart["#{params.category}_bool"] ? true : false )
          ).on(:change) {
            params.heart["#{params.category}_bool"] = !params.heart["#{params.category}_bool"]
          }
        }
        Sem.GridColumn {
          Sem.Header(as: :h3, color: :blue) { " #{params.name}" }
        }
      }
    }
  end

  def category_tabs
    goals   = Sem.TabPane { params.heart.send("#{params.category}_goals")   }.as_node
    signals = Sem.TabPane { params.heart.send("#{params.category}_signals") }.as_node
    metrics = Sem.TabPane { params.heart.send("#{params.category}_metrics") }.as_node
    panes = [ {menuItem: 'Goals',   render: -> { goals.to_n }},
              {menuItem: 'Signals', render: -> { signals.to_n }},
              {menuItem: 'Metrics', render: -> { metrics.to_n }}
    ]
    Sem.Tab(panes: panes.to_n )
  end

  def category_fields
    Sem.Header(as: :h3) { "Goals" }
    Sem.Form {
      TextInplace(field: "#{params.category}_goals", model: params.heart, label: "Goals",
        placeholder: "What are you trying to achieve?", edit_mode: params.edit_mode)
    }
    BR()
    Sem.Header(as: :h3) { "Signals" }
    Sem.Form {
      TextInplace(field: "#{params.category}_signals", model: params.heart, label: "Signals",
        placeholder: "What signals do you expect to see?", edit_mode: params.edit_mode)
    }
    BR()
    Sem.Header(as: :h3) { "Metrics" }
    Sem.Form {
      TextInplace(field: "#{params.category}_metrics", model: params.heart, label: "Metrics",
        placeholder: "And how will you measure this?", edit_mode: params.edit_mode)
    }
  end

end
