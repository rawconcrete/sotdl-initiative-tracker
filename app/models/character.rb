class Character < ApplicationRecord
  validates :name, presence: true
  validates :hp, presence: true, numericality: { greater_than: 0 }
  validates :damage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bonus_hp, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :set_initial_damage

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

  def total_hp
    hp + bonus_hp
  end

  def apply_damage(amount)
    return if amount.nil? || amount <= 0

    # First reduce bonus HP
    if bonus_hp > 0
      if amount <= bonus_hp
        self.bonus_hp -= amount
        amount = 0
      else
        amount -= bonus_hp
        self.bonus_hp = 0
      end
    end

    # Then add to damage if there's still damage to apply
    if amount > 0
      self.damage += amount
    end

    save
  end

  def apply_bonus_hp(amount)
    return if amount.nil?

    if amount.negative?
      subtract_bonus_hp(-amount)
    else
      self.bonus_hp += amount
    end

    save
  end

  def remove_bonus_hp
    self.bonus_hp = 0
    save
  end

  def heal_damage(amount)
    return if amount.nil? || amount <= 0

    # reduce damage first
    if amount <= damage
      self.damage -= amount
    else
      # if extra healing, restore bonus HP
      self.bonus_hp += (amount - damage)
      self.damage = 0
    end

    save
  end

  private

  def set_initial_damage
    self.damage ||= 0
    self.bonus_hp ||= 0
  end

  def subtract_bonus_hp(amount)
    self.bonus_hp -= [amount, bonus_hp].min # ensure bonus HP does not go below 0
  end
end
