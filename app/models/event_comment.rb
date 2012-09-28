class EventComment < ActiveRecord::Base
  
  belongs_to :user                                 # null if anonymous comment
  belongs_to :event

  validates_length_of :user_name, :within => 5..40
  validates :user_email, :email => true
  
  before_validation do
    if user
      self.user_name = user.full_name
      self.user_email = user.email
    end
    true
  end
  
end
