# encoding: utf-8
require 'spec_helper'

describe List do
  before do
    @list = Factory.create :list
  end
  it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_most(200)}
  it { should allow_value(true).for(:public)}
  it { should allow_value(false).for(:public)}
  it { should have_many(:tasks) }
  it { should belong_to(:user) }

  it "should be return status 'Pública' when the list is public" do
    @list.status.should be_eql("Pública")
  end

  it "should be return status 'Privada' when the list isn't public" do
    @list.public = false
    @list.status.should be_eql("Privada")
  end
  it "can be accessed if is public" do
    @list.can_access?(@list.user.id).should be_true
  end
  it "can be accessed if isn't public, but the author is the same user" do
    @list.public = false
    @list.can_access?(@list.user.id).should be_true
  end
  it "can't be accessed if isn't public, and the user isn't the author" do
    @user = Factory.create :user
    @other = Factory.create :other
    @list.public = false
    @list.user = @user
    @list.save
    @list.can_access?(@other.id).should_not be_true
  end
  it "can't be watched for the same user" do
    @user = Factory.create :user
    @list.can_watch?(@user.id).should_not be_true
  end
  it "can't be watched if it's be watched" do
    @user = Factory.create :other
    @user.watches << Watch.new(:list => @list, :user => @user)
    @user.save
    @list.can_watch?(@user.id).should_not be_true
  end
  it "can be watched if the user not been watching and isn't the owner " do
    @user = Factory.create :user
    @other = Factory.create :other
    @list.user = @user
    @list.save
    @list.can_watch?(@other.id).should be_true
  end
  it "should return the user name when call user_name" do
    @list.user_name.should be_eql("Teste")
  end
end
