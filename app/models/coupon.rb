class Coupon < ActiveRecord::Base
  def initialize
    super()
    self.coupon = random_string_of_length(16).upcase
    self.used_count = 0
    self.use_limit = 1
  end

  def expired?
    (self.used_count >= self.use_limit) || (self.numdays != 0 && self.created_at + self.numdays.days < Time.now)
  end
  
  def expiration_date=(v)
    if v.blank?
      self[:numdays] = nil 
    else
      self.created_at = Time.now unless !self.created_at.nil?
      self[:numdays] = (Date.parse(v) - self.created_at.to_date).to_i
    end      
  end
  
  def expiration_date
    return nil if self.numdays == 0
    (self.created_at + self.numdays.days).to_date
  end

  private
  def random_string_of_length(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    s = ""
    1.upto(len) { |i| s << chars[rand(chars.size-1)] }
    return s
  end

end
