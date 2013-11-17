require 'spec_helper'

describe Snapcat::Media do
  describe '.new' do
    it 'decrypts data'
  end

  describe '#valid?' do
    describe 'when invalid' do
      it 'returns false'
    end

    describe 'when valid' do
      it 'returns true'
    end
  end

  describe '#image?' do
    describe 'when it is an image' do
      it 'returns true'
    end

    describe 'when it is not an image' do
      it 'returns false'
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
