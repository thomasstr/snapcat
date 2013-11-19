require 'spec_helper'

describe Snapcat::Media do
  describe '.new' do
    it 'decrypts data'
  end

  describe '#valid?' do
    context 'when invalid' do
      it 'returns false'
    end

    context 'when valid' do
      it 'returns true'
    end
  end

  describe '#image?' do
    context 'when it is an image' do
      it 'returns true'
    end

    context 'when it is not an image' do
      it 'returns false'
    end
  end

  describe '#video?' do
    context 'when it is a video' do
      it 'returns true'
    end

    context 'when it is not a video' do
      it 'returns false'
    end
  end
end
