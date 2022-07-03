class Story < ApplicationRecord
  acts_as_tenant(:organization)

  #== SCOPES ===============================================

  #== ASSOCIATIONS =========================================

  belongs_to :writer, :class_name => 'User', optional: true
  belongs_to :reviewer, :class_name => 'User', optional: true

  #== ENUMS ================================================

  enum status: { unassigned: 0, draft: 1, for_review: 2, in_review: 3, peding: 4, approved: 5, published: 6, archived: 7 }

  #== ACCEPTED ATTRIBUTES ==================================

  #== VALIDATIONS ==========================================

  validates :title, presence: true

  #== CALLBACKS ============================================

  #== INSTANCE METHODS =====================================

  def status_name
    case status
    when 'unassigned'
      'Unassigned'
    when 'draft'
      'Draft'
    when 'for_review'
      'For Review'
    when 'in_review'
      'In Review'
    when 'peding'
      'Peding'
    when 'Approved'
      'Approved'
    when 'Published'
      'Published'
    when 'archived'
      'Archived'
    end
  end

  #== CLASS METHODS ========================================

end
