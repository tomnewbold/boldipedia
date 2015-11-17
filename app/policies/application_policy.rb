class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    
  end



  def show?
    if user.standard?
      true
    else
      false
    end
    
    
  end

  def downgrade?
    if user.premium?
      true
    else
      false
    end
  end

  def create?
    if user.present?
      true
    else
      false
    end
    
  end

  def new?
    create?
  end


  def update?
    user.present?

  end

  def edit?
    update?
  end

  def destroy?
    if user.present? && user.admin? #|| record.user == user)
      true
    else
      false
    end
    
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
