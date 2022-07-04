class Comment < ApplicationRecord
  acts_as_tenant(:organization)

  #== SCOPES ===============================================

  #== ASSOCIATIONS =========================================

  belongs_to :user
  belongs_to :story

  #== ENUMS ================================================

  #== ACCEPTED ATTRIBUTES ==================================

  #== VALIDATIONS ==========================================

  validates :body, presence: true, allow_blank: false

  #== CALLBACKS ============================================

  #== INSTANCE METHODS =====================================

  #== CLASS METHODS ========================================
end
