class Character < ApplicationRecord
  validates :name, presence: true

  scope :allies, -> { where(is_ally: true) }
  scope :enemies, -> { where(is_ally: false) }
  scope :fast, -> { where(fast_turn: true) }
  scope :slow, -> { where(fast_turn: false) }

  def self.ordered_for_initiative
    [
      fast.allies.order(:id),
      fast.enemies.order(:id),
      slow.allies.order(:id),
      slow.enemies.order(:id)
    ].flatten
  end

  def initiative_group
    group = fast_turn? ? "Fast" : "Slow"
    type = is_ally? ? "Ally" : "Enemy"
    "#{group} #{type}"
  end
end
