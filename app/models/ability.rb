class Ability
  include CanCan::Ability

  def initialize(member)
    member ||= Member.new

    can :destroy, Post, author_id: member.id
    can :update, Comment, author_id: member.id
    can :destroy, Comment, author_id: member.id
    can :destroy, :all if member.is? :admin
    can :read, :all
    can :create, :all
  end
end
