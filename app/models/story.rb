class Story < ApplicationRecord
  acts_as_tenant(:organization)
  include Discard::Model
  default_scope -> { kept }
  has_rich_text :content
  #== SCOPES ===============================================

  #== ASSOCIATIONS =========================================

  belongs_to :writer, :class_name => 'User', optional: true
  belongs_to :reviewer, :class_name => 'User', optional: true
  has_many :comments, dependent: :destroy

  #== ENUMS ================================================

  enum status: { unassigned: 0, draft: 1, for_review: 2, in_review: 3, pending: 4, approved: 5, published: 6, archived: 7 }

  #== ACCEPTED ATTRIBUTES ==================================

  attr_accessor :skip_some_callbacks

  #== VALIDATIONS ==========================================

  validates :title, presence: true

  #== CALLBACKS ============================================

  before_save :status_changes_on_update_story
  skip_callback :save, :before, :status_changes_on_update_story, if: :skip_some_callbacks

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
    when 'pending'
      'Pending'
    when 'approved'
      'Approved'
    when 'published'
      'Published'
    when 'archived'
      'Archived'
    end
  end

  def status_changes_on_update_story
    if self.status == 'unassigned'
      if self.writer_id.present?
        self.status = 'draft' 
        save
      end
    end
    if self.status == 'pending'
      self.status = 'draft'
      save
    end
    if self.status == 'archived'
      self.discard
    end
  end
  

  #== CLASS METHODS ========================================

end
