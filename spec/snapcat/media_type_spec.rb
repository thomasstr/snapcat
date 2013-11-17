require 'spec_helper'

describe Snapcat::MediaType do
  describe '#image?' do
    describe 'when it is an image' do
      it 'returns true'
    end

    describe 'when it is not an image' do
      it 'returns false'
    end
  end

  describe '#file_extension' do
    describe 'when it is a video' do
      it 'returns mp4'
    end

    describe 'when it is a image' do
      it 'returns jpg'
    end
  end

  describe '#video?' do
    describe 'when it is a video' do
      it 'returns true'
    end

    describe 'when it is not a video' do
      it 'returns false'
    end
  end
end
