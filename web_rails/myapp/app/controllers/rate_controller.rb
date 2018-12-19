class RateController < ApplicationController
  def create
    @spot = params[:'spot_id']
    if Rating.create(user_id: current_user.id , spot_id: @spot)
      Spot.where('id = ?', @spot).update_all("rate = rate + 1")
      redirect_to search_detail_path(spot_id: @spot)
    else  
      redirect_to root_path
    end
  end

  def destroy
    @spot = params[:'spot_id']
    if rate = Rating.find_by(user_id: current_user.id , spot_id: @spot)
      rate.delete
      Spot.where('id = ?', @spot).update_all("rate = rate - 1")
      redirect_to search_detail_path(spot_id: @spot)
    else
      redirect_to root_path
    end
  end
end
