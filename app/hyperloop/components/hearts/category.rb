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
      } if params.heart["#{params.category}_bool"] || params.edit_mode
      Sem.GridRow {
        Sem.GridColumn {
          category_tabs
          Sem.Divider(hidden: true)
         }
      } if params.heart["#{params.category}_bool"]
    } if params.heart["#{params.category}_bool"] || params.edit_mode
  end

  def heading
    Sem.Header(as: :h2, color: :blue) {
      SPAN { params.name }
      # Sem.HeaderSubheader { params.description }
    } if params.heart["#{params.category}_bool"]
  end

  def check_box
    Sem.Grid {
      Sem.GridRow(columns: 2) {
        Sem.GridColumn(width: 1) {
          Sem.Checkbox(toggle: true, checked: (params.heart["#{params.category}_bool"] ? true : false )
          ).on(:change) {
            params.heart["#{params.category}_bool"] = !params.heart["#{params.category}_bool"]
          }
        }
        Sem.GridColumn(width: 15) {
          Sem.Header(as: :h2, color: :blue) {
            SPAN { params.name }
            Sem.HeaderSubheader { params.description }
          }
        }
      }
    }
  end

  def category_tabs
    goals = Sem.TabPane(attached: true) {
      TextInplace(field: "#{params.category}_goals", model: params.heart,
      placeholder: "What are you trying to achieve?", edit_mode: params.edit_mode)
    }.as_node

    signals = Sem.TabPane(attached: true) {
      TextInplace(field: "#{params.category}_signals", model: params.heart,
      placeholder: "What signals do you expect to see?", edit_mode: params.edit_mode)
    }.as_node

    metrics = Sem.TabPane(attached: true) {
      TextInplace(field: "#{params.category}_metrics", model: params.heart,
      placeholder: "And how will you measure this?", edit_mode: params.edit_mode)
    }.as_node

    panes = [ {menuItem: 'Goals',   render: -> { goals.to_n }},
              {menuItem: 'Signals', render: -> { signals.to_n }},
              {menuItem: 'Metrics', render: -> { metrics.to_n }}
    ]
    menu = { secondary: true, pointing: true }
    Sem.Tab(menu: menu.to_n, panes: panes.to_n )
  end

end
