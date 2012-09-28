require 'iconv'



puts 'LOADING!!!!'

class String

  def to_permalink
    s = Iconv.iconv('ASCII//IGNORE//TRANSLIT', 'UTF-8', self).to_s
    s.gsub!(/\W+/, ' ')
    s.strip!
    s.downcase!
    s.gsub!(/\ +/, '-')
    s
  end
  
end