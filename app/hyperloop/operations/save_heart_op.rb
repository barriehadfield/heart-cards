class SaveHeartOp < Hyperloop::Operation
  param :heart

  step { params.heart.created_by = Member.current if params.heart.new? }
  step { params.heart.updated_by = Member.current }
  step { params.heart.save.then } # NOTE: The .then chains the promise and returns the result
end
