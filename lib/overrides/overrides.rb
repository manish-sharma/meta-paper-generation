module PaperGeneration
  require 'matrix'

  class Matrix < Matrix
    def []=(i, j, x)
      @rows[i][j] = x
    end

    # Return index of maximum number in the matrix
    # (last occuring index is returned, if max number occur multiple times)
    #
    # @return [Array] array in the form of [row,column]
    # @author Shobhit Dixit
    def index_of_max
      max_with_index = self.each_with_index.max
      [max_with_index[1],max_with_index[2]]
    end

    # Return maximum number with index in the matrix
    # (last occuring index is returned, if max number occur multiple times)
    #
    # @return [Array] array in the form of [max_num,row,column]
    # @author Shobhit Dixit
    def max_with_index
      self.each_with_index.max
    end
  end


  class Vector

    # Return index of maximum number in the vector
    # (last occuring index is returned, if max number occur multiple times)
    #
    # @return [Integer] Index
    # @author Shobhit Dixit
    def index_of_max
      self.each_with_index.max[1]
    end
  end


  class Array

    # Return index of maximum number in the vector
    # (last occuring index is returned, if max number occur multiple times)
    #
    # @return [Integer] Index
    # @author Shobhit Dixit
    def index_of_max
      self.each_with_index.max[1]
    end
  end

end
