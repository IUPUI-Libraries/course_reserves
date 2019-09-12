class CoursePolicy < ApplicationPolicy
  def show?
    user.admin? || record.user_id == user.id || record.instructor_username == user.uid
  end

  def create?
    user.admin? || user.role?(:instructor)
  end

  def edit?
    user.admin? || record.user_id == user.id || record.instructor_username == user.uid
  end

  def destroy?
    user.admin?
  end

  def update?
    user.admin? || record.user_id == user.id || record.instructor_username == user.uid
  end

  def available?
    user.admin?
  end

  def expired?
    user.admin? || record.user_id == user.id || record.instructor_username == user.uid
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id).or(scope.where(instructor_username: user.uid))
      end
    end
  end
end
