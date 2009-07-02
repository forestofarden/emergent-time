class EventComment
  include DataMapper::Resource
  
  # TODO.  after dm-is-remixable can handle validation hooks and belongs_to,
  #        combine with TimelineComment and use remixable
  
  property :id, Serial

  property :user_name, String, :size => 5..40, :nullable => false
  property :user_email, String, :nullable => false
  property :user_ip, String, :nullable => false
  belongs_to :user                                 # null if anonymous comment
  
  property :text, Text, :nullable => false

  belongs_to :event
  
  property :created_at, DateTime
  
  validates_format :user_email, :as => :email_address
  
  before :valid? do
    if user
      self.user_name = user.full_name
      self.user_email = user.email
    end
    true
  end
  
end
