class Categories < Hyperloop::Component

  param :heart
  param :edit_mode

  render(DIV) do
    [ { category: :happiness, name: "Happiness", description: "Measures of user's attitudes" },
      { category: :engagement, name: "Engagement", description: "Level of user involvement" },
      { category: :adoption, name: "Adoption", description: "Gaining new users" },
      { category: :retention, name: "Retention", description: "Rate at which existing users are returning" },
      { category: :task, name: "Task Success", description: "Efficiency, effectiveness, and error rate" }
    ].each do |cat|
      Category(category: cat[:category], name: cat[:name], description: cat[:description],
        edit_mode: params.edit_mode, heart: params.heart)
    end
  end
end
