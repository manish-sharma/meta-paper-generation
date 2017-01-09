require 'spec_helper'
describe PaperGeneration::SfBasedSelection do
  # pending "write it"
  it 'PaperGeneration::SfBasedSelection expect to inherit PaperGeneration::QuestionSelection' do
    expect(described_class).to be < PaperGeneration::QuestionSelection
  end

  let(:dl_required_question_count_hash) {{:easy => 6, :medium => 0, :tough => 0}}
  let(:tag_ids_required_question_count_hash) {{["a"]=>2,["b"]=>2,["c"]=>1,["d"]=>1}}
  let(:q_id_tags_hash_array) {[{1=>["a","b"],2=>["a","c"],3=>["a","c","d"],4=>["a"],5=>["a","b"],6=>["d"]}, {},{}]}
  let(:sf_sel) { PaperGeneration::SfBasedSelection.new(dl_required_question_count_hash, tag_ids_required_question_count_hash) }

  it 'expect sf_sel should be an instance of PaperGeneration::SfBasedSelection' do
    expect(sf_sel).to be_an_instance_of PaperGeneration::SfBasedSelection
  end
  it 'expect instance variable dl_required_question_count_hash is initialized as Hash' do
    expect(sf_sel.dl_required_question_count_hash).to be_an_instance_of Hash
  end
  it 'expect instance variable selected_q_ids is initialized as Array' do
    expect(sf_sel.selected_q_ids).to be_an_instance_of Array
  end
  it 'expect instance variable dl_required_question_count_hash is initialized as the given difficulty level required question count' do
    expect(sf_sel.dl_required_question_count_hash).to equal(dl_required_question_count_hash)
  end
  it 'expect instance variable selected_q_ids is initialized as empty Array' do
    expect(sf_sel.selected_q_ids).to eql([])
  end
  it 'expect to set instance variable avail_q_matrix and selection_factor_matrix' do
    sf_sel.generate(q_id_tags_hash_array[0],q_id_tags_hash_array[1],q_id_tags_hash_array[2])
    expect(sf_sel.avail_q_matrix).to be_an_instance_of PaperGeneration::Matrix
    expect(sf_sel.selection_factor_matrix).to be_an_instance_of PaperGeneration::Matrix
  end
  it 'expect to instance variable selected_q_ids to be a subset of avail_q_matrix' do
    h = {}
    expect((q_id_tags_hash_array.inject(h,:update).keys)).to include(*sf_sel.selected_q_ids)
  end
end
