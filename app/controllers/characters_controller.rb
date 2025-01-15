class CharactersController < ApplicationController
  def index
    @characters = Character.ordered_for_initiative
    @new_character = Character.new
  end

  def create
    @character = Character.new(character_params)

    puts "Character params: #{character_params.inspect}"

    if @character.save
      redirect_to root_path, notice: 'Character added!'
    else
      puts "Character errors: #{@character.errors.full_messages}"
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

  def toggle_speed
    @character = Character.find(params[:id])
    @character.update(fast_turn: !@character.fast_turn)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def apply_damage
    @character = Character.find(params[:id])
    damage_amount = params[:damage_amount].to_i

    if damage_amount.negative?
      @character.heal_damage(-damage_amount)
    else
      @character.apply_damage(damage_amount)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end


  def apply_bonus_hp
    @character = Character.find(params[:id])
    bonus_hp_amount = params[:bonus_hp_amount].to_i
    @character.apply_bonus_hp(bonus_hp_amount)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end


  def remove_bonus_hp
    @character = Character.find(params[:id])
    @character.remove_bonus_hp

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
    params.require(:character).permit(:name, :hp, :is_ally, :fast_turn)
  end
end
