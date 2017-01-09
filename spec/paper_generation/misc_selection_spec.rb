require 'spec_helper'
describe PaperGeneration::MiscSelection do
  # pending "write it"
  it 'PaperGeneration::MiscSelection expect to inherit PaperGeneration::QuestionSelection' do
    expect(described_class).to be < PaperGeneration::QuestionSelection
  end

  let(:dl_required_question_count_hash) {{:easy => 6, :medium => 0, :tough => 0}}
  let(:q_ids) {[[1,2,3,4,13,14,15,16],[5,6,7,8],[9,10,11,12]]}
  let(:msc_sel) { PaperGeneration::MiscSelection.new(dl_required_question_count_hash) }

  it 'expect msc_sel should be an instance of PaperGeneration::MiscSelection' do
    expect(msc_sel).to be_an_instance_of PaperGeneration::MiscSelection
  end
  it 'expect instance variable dl_required_question_count_hash is initialized as Hash' do
    expect(msc_sel.dl_required_question_count_hash).to be_an_instance_of Hash
  end
  it 'expect instance variable selected_q_ids is initialized as Array' do
    expect(msc_sel.selected_q_ids).to be_an_instance_of Array
  end
  it 'expect instance variable dl_required_question_count_hash is initialized as the given difficulty level required question count' do
    expect(msc_sel.dl_required_question_count_hash).to equal(dl_required_question_count_hash)
  end
  it 'expect instance variable selected_q_ids is initialized as empty Array' do
    expect(msc_sel.selected_q_ids).to eql([])
  end
  it 'expect to set instance variable avail_q_array' do
    msc_sel.generate(q_ids)
    expect(msc_sel.avail_q_array).to be_an_instance_of Array
    expect((q_ids.flatten)).to include(*msc_sel.avail_q_array.flatten)
  end
  it 'expect to instance variable selected_q_ids to be a subset of avail_q_array' do
    expect(q_ids.flatten).to include(*msc_sel.selected_q_ids)
  end


end
