class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  #== SCOPES ===============================================

  #== ASSOCIATIONS =========================================

  has_many :users, inverse_of: :organization
  
  #== ENUMS ================================================

  #== ACCEPTED ATTRIBUTES ==================================

  #== VALIDATIONS ==========================================

  validates :name, :slug, presence: true

  #== CALLBACKS ============================================

  #== INSTANCE METHODS =====================================

  # Generate a new slug when organization name change
  def should_generate_new_friendly_id?
    name_changed? || super
  end

  # Use default slug with 8 characters only
  def normalize_friendly_id(string)
    super.slice!(0..7)
  end

  # Avoiding have a big slug when have a friedly id conflict
  def resolve_friendly_id_conflict(candidates)
    random_string = Array.new(2) { [*'A'..'Z'].sample }.join
    [candidates.first, random_string].compact.join(friendly_id_config.sequence_separator)
  end

  #== CLASS METHODS ========================================
end
