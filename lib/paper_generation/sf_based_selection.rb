module PaperGeneration

  class SfBasedSelection < QuestionSelection

    @tag_ids_required_question_count_hash = nil
    # => @tag_ids_required_question_count_hash = {[1,2,3] => 10, [4]=>2,[5,6]=>5}
    @avail_q_matrix = nil
    @t_dl_req_q_count_matrix = nil
    @dl_required_question_count_hash = nil
    @required_tags = nil
    @selected_q_ids = nil

    # avail_q_matrix
    #
    # @return [Matrix] return martix avail_q_matrix
    # @author Shobhit Dixit
    def avail_q_matrix
      @avail_q_matrix
    end

    # selection_factor_matrix
    #
    # @return [Matrix] return selection_factor_matrix
    # @author Shobhit Dixit
    def selection_factor_matrix
      @selection_factor_matrix
    end

    # Method that set q_availability_matrix
    #
    # @param [Hash] easy_q_id_tags_hash={}
    # @example {easy_q_id=>[tag1_id,tag2_id,..]}
    # @param [Hash] medium_q_id_tags_hash={}
    # @example {medium_q_id=>[tag1_id,tag2_id,..]}
    # @param [Hash] tough_q_id_tags_hash={}
    # @example {tough_q_id=>[tag1_id,tag2_id,..]}
    # @return [Matrix] avail_q_matrix
    # @see generate
    # @author Shobhit Dixit
    def set_q_availability_matrix(easy_q_id_tags_hash={}, medium_q_id_tags_hash={}, tough_q_id_tags_hash={})
      tags_dls_avail_q = []
      @required_tags.each do |t_ids|
        t_ids_easy_avail_q = easy_q_id_tags_hash.map{|k,v| k if !(v & t_ids).empty?}.compact
        t_ids_medium_avail_q = medium_q_id_tags_hash.map{|k,v| k if !(v & t_ids).empty?}.compact
        t_ids_tough_avail_q = tough_q_id_tags_hash.map{|k,v| k if !(v & t_ids).empty?}.compact
        tags_dls_avail_q << [t_ids_easy_avail_q, t_ids_medium_avail_q, t_ids_tough_avail_q]
      end
      @avail_q_matrix = Matrix.rows(tags_dls_avail_q)
    end

    # Method that set selection_factor_matrix
    #
    # @return [Matrix] selection_factor_matrix
    # @author Shobhit Dixit
    def set_selection_factor_matrix
      sf_array = []
      @required_tags.each do |t_ids|
        avail_q_matrix_row = @avail_q_matrix.row(@required_tags.index(t_ids)).to_a
        t_ids_sf = [ ((avail_q_matrix_row[0].count>0 && @dl_required_question_count_hash[:easy]>0 && @tag_ids_required_question_count_hash[t_ids]>0) ? ((@dl_required_question_count_hash[:easy]+@tag_ids_required_question_count_hash[t_ids]).to_r/avail_q_matrix_row[0].count): 0),
                     ((avail_q_matrix_row[1].count>0 && @dl_required_question_count_hash[:medium]>0 && @tag_ids_required_question_count_hash[t_ids]>0) ? ((@dl_required_question_count_hash[:medium]+@tag_ids_required_question_count_hash[t_ids]).to_r/avail_q_matrix_row[1].count): 0),
                     ((avail_q_matrix_row[2].count>0 && @dl_required_question_count_hash[:tough]>0 && @tag_ids_required_question_count_hash[t_ids]>0) ? ((@dl_required_question_count_hash[:tough]+@tag_ids_required_question_count_hash[t_ids]).to_r/avail_q_matrix_row[2].count): 0)
                   ]
        sf_array << t_ids_sf
      end
      @selection_factor_matrix = Matrix.rows(sf_array)
    end

    # Method that generates question id selection PhaseOne process
    # override method of parent class
    #
    # @param [Hash] easy_q_id_tags_hash={}
    # @example {easy_q_id=>[tag1_id,tag2_id,..]}
    # @param [Hash] medium_q_id_tags_hash={}
    # @example {medium_q_id=>[tag1_id,tag2_id,..]}
    # @param [Hash] tough_q_id_tags_hash={}
    # @example {tough_q_id=>[tag1_id,tag2_id,..]}
    # @author Shobhit Dixit
    def generate(*args)
      set_q_availability_matrix(args[0], args[1], args[2])
      set_selection_factor_matrix
      max_selection_factor = @selection_factor_matrix.max_with_index
      while(max_selection_factor[0] > 0)
        # p "am : #{@avail_q_matrix}"
        # p "sf : #{@selection_factor_matrix}"
        # p [max_selection_factor[1], max_selection_factor[2]]
        q_id = select_q_from((@avail_q_matrix[max_selection_factor[1], max_selection_factor[2]]).to_a)
        update_tag_dl_required_q_counts(max_selection_factor[1], max_selection_factor[2])
        # as selected question shall have only one difficulty level,
        # and it will be removed from that column only
        update_avail_q_matrix_column(max_selection_factor[2], q_id)
        set_selection_factor_matrix
        max_selection_factor = @selection_factor_matrix.max_with_index
        @selected_q_ids << q_id if !q_id.nil?
      end
    end

    # Method to update available question matrix
    #
    # @param [Integer] column_index
    # @param [Integer] q_id
    # @author Shobhit Dixit
    def update_avail_q_matrix_column(column_index, q_id)
      @avail_q_matrix.each_with_index do |elem, row, col|
        if !(elem&[q_id]).empty? && col == column_index
          @avail_q_matrix[row, col] -= [q_id]
        end
      end
    end

    def update_tag_dl_required_q_counts(row_index, column_index)
      @tag_ids_required_question_count_hash[@required_tags[row_index]] -= 1 if @tag_ids_required_question_count_hash[@required_tags[row_index]]>0
      @dl_required_question_count_hash[dl_name(column_index)] -= 1 if @dl_required_question_count_hash[dl_name(column_index)]>0
    end

    def dl_name(column_index)
      case column_index
      when 0
        return :easy
      when 1
        return :medium
      when 2
        return :tough
      end
    end

  end
end
