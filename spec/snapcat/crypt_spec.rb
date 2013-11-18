require 'spec_helper'

describe Snapcat::Crypt do
  describe '.decrypt' do
    it 'decrypts the data' do
      encrypted_data = DataHelper.data_for(:encrypted)
      decrypted_data = Snapcat::Crypt.decrypt(encrypted_data)

      decrypted_data.must_equal DataHelper.data_for(:decrypted)
    end
  end

  describe '.encrypt' do
    it 'encrypts the data' do
      decrypted_data = DataHelper.data_for(:decrypted)
      encrypted_data = Snapcat::Crypt.encrypt(decrypted_data)

      encrypted_data.must_equal DataHelper.data_for(:encrypted)
    end
  end
end
