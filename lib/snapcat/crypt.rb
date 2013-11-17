module Snapcat
  module Crypt
    AES_MODE = '128-ECB'
    ENCRYPTION_KEY = 'M02cnQ51Ji97vwT4'

    extend self

    def decrypt(data)
      cipher = new_cipher(:decrypt)
      finish_crypt(cipher, data)
    end

    def encrypt(data)
      cipher = new_cipher(:encrypt)
      finish_crypt(cipher, data)
    end

    private

    def finish_crypt(cipher, data)
      cipher.key = BLOB_ENCRYPTION_KEY
      cipher.update(pkcs5_pad(data)) + cipher.final
    end

    def new_cipher(mode)
      cipher = OpenSSL::Cipher::AES.new(AES_MODE)
      cipher.send(mode)
    end

    def pkcs5_pad(data, blocksize = 16)
      padding = data.length % blocksize
      "#{data}#{padding.chr * padding}"
    end
  end
end
