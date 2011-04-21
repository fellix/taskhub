require 'spec_helper'

describe List do
  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_most(200)}
  it { should allow_value(true).for(:public)}
  it { should allow_value(false).for(:public)}
  it { should have_many(:tasks) }
  it { should belong_to(:user) }
end
