module PostgreSQLHelpers

  def sanitize_tsquery(q)
    # TODO.  support +/- instead of & and |
    rules = {
      / /          => '|',          # separate words are 'or'
      / and /      => '&',          # allow english booleans
      / or /       => '|',          # ''
      /[^A-Za-z0-9\|\&]/ => ''      # delete all other spurious chars
    }

    q = q.strip
    rules.each do |pattern, result|
      q = q.gsub(pattern, result)
    end
    q
  end
end