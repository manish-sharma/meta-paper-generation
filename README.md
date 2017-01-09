# meta-paper-generation
## Installation

In your Gemfile, add  
`gem 'meta-paper-generation', github: 'manish-sharma/meta-paper-generation'`

## Usage
Get question_ids based on selection factor mechanism  
`dl_required_question_count_hash = {:easy => 6, :medium => 0, :tough => 0}`  
`tag_ids_required_question_count_hash = {[tag_id1]=>2,[tag_id2]=>2,[tag_id3]=>1,[tag_id4]=>1}`  
`easy_q_id_tags_hash = {qid1=>[tag_id1,tag_id2],qid2=>[tag_id1,tag_id3],qid3=>[tag_id1,tag_id3,tag_id4],qid4=>[tag_id1],qid5=>[tag_id1,tag_id2],qid6=>[tag_id4]}`  
`medium_q_id_tags_hash = {}`  
`tough_q_id_tags_hash = {}`  

`obj = SfBasedSelection.new(dl_required_question_count_hash, tag_ids_required_question_count_hash)`  
`obj.generate(easy_q_id_tags_hash,medium_q_id_tags_hash,tough_q_id_tags_hash)`  
`obj.selected_q_ids`  
shall return the selected question ids after selection process.  
`obj.tag_ids_required_question_count_hash`  
shall return tag_ids_required_question_count_hash after selection process.    
`obj.dl_required_question_count_hash`  
shall return dl_required_question_count_hash after selection process.

For miscellaneous selection mechanism,  
`m_obj = MiscSelection.new(obj.dl_required_question_count_hash)`  
 `m_obj.generate([easy_q_id_tags_hash.keys - obj.selected_q_ids,medium_q_id_tags_hash.keys - obj.selected_q_ids,tough_q_id_tags_hash.keys - obj.selected_q_ids])`  
 In generate method, we are passing array of easy_q_ids, medium_q_ids, tough_q_ids excluding selected_q_ids from all.  
 `m_obj.selected_q_ids`  
 shall return selected question ids after miscellaneous selection mechanism.
