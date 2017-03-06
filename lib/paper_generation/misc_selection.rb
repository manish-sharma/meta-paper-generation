module PaperGeneration

  class MiscSelection < QuestionSelection

    # array of questions[[easy_q_ids], [medium_q_ids], [tough_q_ids]]
    @avail_q_array = nil
    @dl_required_question_count_hash = nil
    @selected_q_ids = nil

    # avail_q_array
    #
    # @return [Array] Array of available question_id
    # @author Shobhit Dixit
    def avail_q_array
      @avail_q_array
    end

    # tag_ids_required_question_count_hash
    #
    # @raise NoMethodError
    # @author Shobhit Dixit
    def tag_ids_required_question_count_hash
      raise NoMethodError
    end

    # Generate Misc. questions selection
    #
    # @param [Array] avail_q_array [[easy_q_ids], [medium_q_ids], [tough_q_ids]]
    # @return [Array] Array of selected_q_ids
    # @author Shobhit Dixit
    def generate(*args)
      @avail_q_array = args[0]
      # easy_q_ids + medium_q_ids + tough_q_ids
      @selected_q_ids = select_q(0, @dl_required_question_count_hash[:easy]) + select_q(1, @dl_required_question_count_hash[:medium]) + select_q(2, @dl_required_question_count_hash[:tough])
    end

    # select q_ids from @avail_q_array[index]
    #
    # @private
    # @param [Integer] index difficulty_level
    # @param [Integer] q_count number of questions to be selected`
    # @return [Array] array of q_ids(Integer)
    # @author Shobhit Dixit
    def select_q(index, q_count)
      selected_q_ids = []
      while q_count>0 && !@avail_q_array[index].empty?
        selected_question = select_q_from(@avail_q_array[index])
        selected_q_ids << selected_question
        @avail_q_array[index].delete(selected_question)
        q_count -=1
      end
      selected_q_ids
    end

    private :select_q

  end
end
