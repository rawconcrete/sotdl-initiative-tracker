class CharactersController < ApplicationController
  def index
    @characters = Character.ordered_for_initiative
    @new_character = Character.new
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      redirect_to root_path, notice: 'Character added!'
    else
      @characters = Character.ordered_for_initiative
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    redirect_to root_path, notice: 'Character removed!'
  end

  def toggle_acted
    @character = Character.find(params[:id])
    @character.update(acted: !@character.acted)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  # Add this new method
  def toggle_speed
    @character = Character.find(params[:id])
    @character.update(fast_turn: !@character.fast_turn)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def reset_round
    Character.update_all(acted: false)
    redirect_to root_path, notice: 'New round started!'
  end

  private

  def character_params
    params.require(:character).permit(:name, :is_ally, :fast_turn)
  end
end
