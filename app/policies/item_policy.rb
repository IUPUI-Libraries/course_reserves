class ItemPolicy < ApplicationPolicy

  def show?
    user.admin? || record.user_id == user.id
  end

  def create?
    user.admin? || user.role?(:instructor)
  end

  def edit?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  def update?
    user.admin? || record.user_id == user.id
  end

  def permitted_attributes
    if user.admin?
      [:_destroy, :id, :item_status_id, :title, :author, :publication_date, :publisher, :edition, :loan_period, :owner, :call_number, :note, :iucat_id, :bod_format]
    else
      [:_destroy, :id, :title, :author, :publication_date, :publisher, :edition, :loan_period, :owner, :call_number, :note, :iucat_id, :bod_format]
    end
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
        scope.where(user_id: user.id)
      end
    end
  end
end
