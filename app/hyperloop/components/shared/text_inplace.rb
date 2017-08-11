class TextInplace < Hyperloop::Component

  param :field
  param :model
  param :edit_mode
  param :placeholder
  param :label

  render(DIV) do
   if params.edit_mode
     Sem.TextArea(value: params.model[params.field.to_s].to_s, label: params.label,
     placeholder: params.placeholder.to_s, autoHeight: true)
     .on(:change) do |e|
       params.model[params.field.to_s] = e.target.value
     end
   else
    #  H1 { "heading" }
    #  P { params.model.send(params.field) } if params.model.send(params.field)
    puts "not implemented"
   end
 end

end
