class SaveHeartOp < Hyperloop::Operation
  param :heart

  step { params.heart.created_by = Member.current if params.heart.new? }
  step { params.heart.updated_by = Member.current }
  step { save }

  def save
    params.heart.save.then do |result|
      alert "Unable to save Heart Card" unless result[:success]
    end
  end

end
