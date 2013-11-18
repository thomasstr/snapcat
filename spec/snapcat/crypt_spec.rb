require 'spec_helper'

describe Snapcat::Crypt do
  describe '.decrypt' do
    it 'decrypts the data' do
      skip 'need to generate some actual data'
      encrypted_data = DataHelper.encrypted_data
      decrypted_data = Snapcat::Crypt.decrypt(encrypted_data)

      decrypted_data.must_equal DataHelper.decrypted_data
    end
  end

  describe '.encrypt' do
    it 'encrypts the data' do
      skip 'need to generate some actual data'
      decrypted_data = DataHelper.decrypted_data
      encrypted_data = Snapcat::Crypt.encrypt(decrypted_data)

      encrypted_data.must_equal DataHelper.decrypted_data
    end
  end
end
