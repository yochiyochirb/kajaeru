class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if scope.voter == user.voter
        scope
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
