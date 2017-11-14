class TextInplace < Hyperloop::Component

  param :field
  param :model
  param :edit_mode
  param :placeholder

  render(DIV) do
   if params.edit_mode
     Sem.Form {
       Sem.TextArea(value: params.model[params.field.to_s].to_s, placeholder: params.placeholder.to_s, autoHeight: true)
       .on(:change) do |e|
         params.model[params.field.to_s] = e.target.value
       end
     }
   else
     H1 { params.model.send(params.field) }
   end
 end

end
