class SaveHeartOp < Hyperloop::Operation
  param :heart

  step do
    params.heart.created_by = Member.current if params.heart.new?
    params.heart.updated_by = Member.current
    params.heart.save.then
  end
end
