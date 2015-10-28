module ProgressiveRender

class FragmentNameIterator
  def initialize
    @current = 0
  end

  def next!
    @current += 1

    "#{@current}"
  end
end

end