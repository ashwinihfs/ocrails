#
# This is an override for th built in String Class, to extract barious 'Boolean type' values, and return a
# true or false value
#
# TRUE: true, t, yes, y, or 1
# FALSE: false, f, no, n, or 0
class String
  #
  # the to_bool method is added to the string class and it converts a string value that the method is called on to
  # a Boolean True or False value
  #

  # @return [Boolean]       True or False
  def to_bool
    return true   if self == true   || self =~ (/(true|t|yes|y|1)$/i)
    return false  if self == false  || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end
