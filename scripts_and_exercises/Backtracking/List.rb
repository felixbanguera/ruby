class List
  attr_accessor :ary
  attr_accessor :val
  attr_accessor :current_idx
  def initialize(ary)
    @ary = ary
    @current_idx = 0
    @val = ary[0]
  end

  def nextt
    @current_idx += 1
    @val = @ary[@current_idx]
  end

  def end?
    @current_idx == @ary.length
  end
end