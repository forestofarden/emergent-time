class User
  include DataMapper::Resource
  include RepertoireCore::UserMixin
  property :id, Serial
# property :login, String    <<< n.b. commented out

  has n, :timelines
  
  def related(n=5, cutoff=10)
    sql = <<-SQL.compress_lines
    SELECT t2.user_id FROM timelines t1 JOIN timeline_events te1 ON (te1.timeline_id = t1.id),
                            timelines t2 JOIN timeline_events te2 ON (te2.timeline_id = t2.id)
    WHERE t1.user_id = #{id} AND te1.event_id = te2.event_id 
      AND t2.user_id != t1.user_id
    GROUP BY t2.user_id HAVING count(*) > #{cutoff} ORDER BY count(*) DESC LIMIT #{n}
    SQL
    
    result = repository.adapter.query(sql)
    User.all(:id => result)
  end
  
end
