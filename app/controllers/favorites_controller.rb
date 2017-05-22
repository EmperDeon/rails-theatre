class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = Favorite.where(u_web: current_user).collect {|m| m.t_perf}
  end

  def add_to_favorites
    Favorite::create(u_web: current_user, t_perf_id: params[:id])

    redirect_to request.referer
  end

  def del_from_favorites
    f = Favorite::find_by(u_web: current_user, t_perf_id: params[:id])
    f.destroy

    redirect_to '/favorites'
  end
end
