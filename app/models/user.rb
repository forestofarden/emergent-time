class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :first_name, :last_name, :shortname, :password, :password_confirmation
                  
  has_many :timelines
  
  validates_presence_of :first_name, :last_name, :shortname
  validates_format_of :shortname, :with => /\A[a-zA-Z]+\z/, :message => "Only letters allowed"
  validates_length_of :shortname, :within => 5..20
  
  def related(n=5, cutoff=10)
    sql = <<-SQL
    SELECT t2.user_id FROM timelines t1 JOIN timeline_events te1 ON (te1.timeline_id = t1.id),
                            timelines t2 JOIN timeline_events te2 ON (te2.timeline_id = t2.id)
    WHERE t1.user_id = #{id} AND te1.event_id = te2.event_id 
      AND t2.user_id != t1.user_id
    GROUP BY t2.user_id HAVING count(*) >= #{cutoff} ORDER BY count(*) DESC LIMIT #{n}
    SQL
    
    result = repository.adapter.query(sql)
    User.all(:id => result)
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def to_param
    shortname
  end

end
