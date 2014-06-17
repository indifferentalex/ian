class String
  def is_i?
     !!(self =~ /\A[-+]?[0-9]+\z/)
  end

  def is_upper?
    !!self.match(/\p{Upper}/)
  end

  def is_lower?
    !!self.match(/\p{Lower}/)
  end
end