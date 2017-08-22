class Updates < Hyperloop::Component
  param :heart
  param :category

  render(DIV) do
    panels = []
    Update.for_heart_category(params.heart.id, params.category).reverse.each do |update|
      panels << { title: UpdateTitle(update: update).as_node,
                  content: UpdatePanel(update: update).as_node,
                  key: update.id.to_s
      }
    end

    Sem.Accordion(panels: panels.to_n, styled: false, fluid: true) if panels.any?
  end
end

class UpdateTitle < Hyperloop::Component
  param :update
  render do
    SPAN {
      SPAN { "Update from #{params.update.member.full_name} " }
      TimeAgo(date: params.update.updated_at)
    }
  end
end

class UpdatePanel < Hyperloop::Component
  param :update

  render do
    SPAN { params.update.body }
  end
end
