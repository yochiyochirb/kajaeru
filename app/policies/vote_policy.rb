class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless scope.voter.in?(user.voters)
      scope
    end
  end
end
