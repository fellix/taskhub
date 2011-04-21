require 'spec_helper'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  before do
    @user = User.new
    @uploader = AvatarUploader.new @user, :avatar
    @uploader.store!(File.open(Rails.root.join('spec/fixtures/avatar.jpg')))
  end

   it "should be scaled to 50x50 pixels" do
     @uploader.should have_dimensions 50, 50
   end

end