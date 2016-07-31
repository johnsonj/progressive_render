module ProgressiveRender
  # Generates a prefix for a given progressive_render section in a stable manner.
  # This way on each load we assign the outer most progressive_render block with
  # the same name. Nested progressive_render blocks are not supported, this approach
  # may need to be re-evaluated for that use case.
  class FragmentNameIterator
    def initialize
      @current = 0
    end

    def next!
      @current += 1

      @current.to_s
    end
  end
end
