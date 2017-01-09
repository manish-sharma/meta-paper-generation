module PaperGeneration

  class QuestionSelection

    @selected_q_ids = nil
    @dl_required_question_count_hash = nil
    # => @tag_ids_required_question_count_hash = {[1,2,3] => 10, [4]=>2,[5,6]=>5}
    @tag_ids_required_question_count_hash = nil
    # required_tags is there to maintain order of the hash
    @required_tags = nil

    # Constructor
    #
    # @param [Hash] dl_required_question_count_hash {:easy => required_question_count, :medium => required_question_count, :tough => required_question_count}
    # @param [Hash] tag_ids_required_question_count_hash = {[1,2,3] => 10, [4]=>2,[5,6]=>5}
    # @author Shobhit Dixit
    def initialize(dl_required_question_count_hash, tag_ids_required_question_count_hash={})
      @selected_q_ids = []
      @dl_required_question_count_hash = dl_required_question_count_hash
      # => @tag_ids_required_question_count_hash = {[1,2,3] => 10, [4]=>2,[5,6]=>5}
      @tag_ids_required_question_count_hash = tag_ids_required_question_count_hash
      # required_tags is there to maintain order of the hash
      @required_tags = @tag_ids_required_question_count_hash.keys
    end

    # selected_q_ids
    #
    # @return [Array] return Array of selected question_ids
    # @author Shobhit Dixit
    def selected_q_ids
      @selected_q_ids
    end

    # tag_ids_required_question_count_hash
    #
    # @return [Hash]
    # @example {[1,2,3] => 10, [4]=>2,[5,6]=>5}
    # @author Shobhit Dixit
    def tag_ids_required_question_count_hash
      @tag_ids_required_question_count_hash
    end

    # dl_required_question_count_hash
    #
    # @return [Hash]
    # @example {:easy => required_question_count, :medium => required_question_count, :tough => required_question_count}
    # @author Shobhit Dixit
    def dl_required_question_count_hash
      @dl_required_question_count_hash
    end

    # Method that select a question_id from an array of question_id
    #
    # @param [Array] q_id_array
    # @return [Integer] question_id
    # @author Shobhit Dixit
    def select_q_from(q_id_array)
      q_id_array.sample
    end

    # Method to generate question_id selection process
    # Ever process, as PhaseOne, MiscSelection etc must override this method
    #
    # @raise NotImplementedError
    # @author Shobhit Dixit
    def generate
      raise NotImplementedError
    end

  end
end
