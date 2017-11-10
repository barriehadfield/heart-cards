class NewComment < Hyperloop::Component
  param :report

  state open: false

  render(DIV) do
    if state.open
      new_comment
    else
      Sem.Button(size: :mini) { "Comment" }.on(:click) {
        @comment = Comment.new
        mutate.open true
      }
    end
  end

  def new_comment
    Sem.Form {
      Sem.TextArea(value: @comment.body.to_s, placeholder: "Your comment please", autoHeight: true)
      .on(:change) do |e|
        @comment.body = e.target.value
      end
    }
    BR()
    Sem.Button(size: :mini, primary: true) { "Save" }.on(:click) {
      save
    }
    Sem.Button(size: :mini) { "Cancel" }.on(:click) {
      cancel
    }
    Sem.Divider(hidden: true)
  end

  def cancel
    mutate.open false
  end

  def save
    SaveCommentOp.run(comment: @comment, report: params.report).then do |result|
      if result[:success]
        mutate.open false
      else
        alert "Unable to save Comment"
      end
    end
  end

end
