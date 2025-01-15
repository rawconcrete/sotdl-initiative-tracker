module CharactersHelper
  def health_status_class(character)
    return '' if character.hp.nil?

    damage = character.damage || 0
    total_hp = character.total_hp

    # Add these lines to help debug
    Rails.logger.debug "Character: #{character.name}"
    Rails.logger.debug "Total HP: #{total_hp}"
    Rails.logger.debug "Damage: #{damage}"
    Rails.logger.debug "Injured threshold: #{total_hp / 2}"

    return '' if damage == 0
    return 'incapacitated' if damage >= total_hp
    return 'injured' if damage >= (total_hp / 2)
    ''
  end
end
