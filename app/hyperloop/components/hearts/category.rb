class Category < Hyperloop::Component

  param :category
  param :name
  param :description
  param :edit
  param :heart

  render(DIV) do
      H1 { params.name }
  end
end
