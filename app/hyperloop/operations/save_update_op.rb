class SaveUpdateOp < Hyperloop::Operation
  param :heart
  param :update
  param :category

  step { params.update.member = Member.current }
  step { params.update.heart = params.heart }
  step { params.update.category = params.category }
  step { params.update.save.then }
end
