require 'rails_helper'

describe PictureUploader do

  include CarrierWave::Test::Matchers

  before do
    PictureUploader.enable_processing = true
    @uploader = PictureUploader.new(@restaurant, :picture)
    @uploader.store!(File.open(File.join(Rails.root, '/spec/fixtures/pictures/picture.png')))
  end

  after do
    PictureUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 300 x 250 pixels" do
      expect(@uploader.thumb).to be_no_larger_than(300, 250)
    end
  end

  context 'the masthead version' do
    it "should scale down a landscape image to fit within 600 x 500 pixels" do
      expect(@uploader.masthead).to be_no_larger_than(600, 500)
    end
  end

  it "should make the image readable only to the owner and not executable" do
    expect(@uploader).to have_permissions(0644)
  end
end