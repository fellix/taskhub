require 'spec_helper'

describe Watch do
  it { should belong_to :user }
  it { should belong_to :list }
end
