class TrixEditor < Hyperloop::Component
  param :initial_value
  param :model
  param :field
  param :placeholder

  render do
    ReactTrix(
      autoFocus: true,
      placeholder: params.placeholder,
      value: params.initial_value,
      onChange: lambda { |html| change html }
    )
  end

  def change html
    params.model[params.field.to_s] = html
  end

end

# <TrixEditor
#   autoFocus={true}
#   placeholder="editor's placeholder"
#   value="initial content <strong>for the editor</strong>"
#   uploadURL="https://domain.com/imgupload/receiving/post"
#   uploadData={{"key1": "value", "key2": "value"}}
#   mergeTags={mergeTags}
#   onChange={on_change_handler}
#   onEditorReady={on_editor_ready_handler}
# />

# let mergeTags = [{
#   trigger: "@",
#   tags: [
#     {name: "Dominic St-Pierre", tag: "@dominic"},
#     {name: "John Doe", tag: "@john"}
#   ]
# }, {
#   trigger: "{",
#   tags: [
#     {name: "First name", tag: "{{ .FirstName }}"},
#     {name: "Last name", tag: "{{ .LastName }}"}
#   ]
# }]
