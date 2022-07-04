class User < ApplicationRecord
  acts_as_tenant(:organization)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
    authentication_keys: %i[email slug]

  #== SCOPES ===============================================

  #== ASSOCIATIONS =========================================

  has_many :stories
  has_many :comments, dependent: :destroy

  #== ENUMS ================================================

  enum role: { writer: 0, chief_editor: 1 }

  #== ACCEPTED ATTRIBUTES ==================================

  attr_accessor :slug

  #== VALIDATIONS ==========================================

  validates :name, :role, presence: true

  #== CALLBACKS ============================================

  before_create :get_slug

  #== INSTANCE METHODS =====================================

  def role_name
    case role
    when 'writer'
      'Writer'
    when 'chief_editor'
      'Chief Editor'
    end
  end

  #== CLASS METHODS ========================================

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if conditions[:email] && conditions[:slug]
      joins(:organization).where(organizations: { slug: conditions[:slug] }, users: { email: conditions[:email] }).first
    end
  end

  private

  def get_slug
    unless slug.present?
      slug = organization.slug
    end
  end
end
