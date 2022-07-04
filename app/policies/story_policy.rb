class StoryPolicy < ApplicationPolicy
  def index?
    user.chief_editor?
  end

  def create?
    user.chief_editor?
  end

  def update?
    user.chief_editor? ||
      (record.writer == user) ||
      (record.reviewer == user)
  end

  def for_review?
    user.chief_editor? ||
      (record.writer == user)
  end

  def in_review?
    user.chief_editor? ||
      (record.reviewer == user)
  end

  def pending?
    user.chief_editor? ||
      (record.reviewer == user)
  end

  def approved?
    user.chief_editor? ||
      (record.reviewer == user)
  end

  def published?
    user.chief_editor?
  end

  def archived?
    user.chief_editor?
  end
end