require 'spec_helper'

describe Task do
  it { should belong_to(:list) }
  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_most(200) }
end
