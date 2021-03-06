# WSDL4R - XMLSchema complexType definition for WSDL.
# Copyright (C) 2002, 2003, 2005  NAKAMURA, Hiroshi <nahi@ruby-lang.org>.

# This program is copyrighted free software by NAKAMURA, Hiroshi.  You can
# redistribute it and/or modify it under the same terms of Ruby's license;
# either the dual license version in 2003, or any later version.


require 'wsdl/xmlSchema/content'


module WSDL
module XMLSchema


class Sequence < Content
  attr_reader :any

  def initialize
    super()
    @any = nil
  end

  def have_any?
    !!@any
  end

  def parse_element(element)
    case element
    when SequenceName
      o = Sequence.new
      @elements << o
      o
    when ChoiceName
      o = Choice.new
      @elements << o
      o
    when AnyName
      raise ElementConstraintError.new("duplicated element: any") if @any
      @any = Any.new
      @elements << @any
      @any
    else
      super(element)
    end
  end
end


end
end
