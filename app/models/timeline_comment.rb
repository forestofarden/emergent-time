class TimelineComment < ActiveRecord::Base
  # TODO.  after dm-is-remixable can handle validation hooks and belongs_to,
  #        combine with EventComment and use remixable
  belongs_to :user

  belongs_to :timeline
  
  validate :user_email, :email => true
  
  before_validation do 
    if user
      self.user_name = user.full_name
      self.user_email = user.email
    end
  end
  
end
