class WikiPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.present?



    #this method is going to return true or false
    # if true, it oncintues
    #if false, the porgram raisses authorization error
  end
end