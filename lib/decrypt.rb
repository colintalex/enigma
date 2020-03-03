require_relative 'cipher_engine'
require_relative 'enigma'
require_relative 'module/timeable'

file = File.open(ARGV[0], "r")
message = file.read
file.close
@enigma = Enigma.new
decrypted = @enigma.decrypt(message, ARGV[2], ARGV[3])

writer = File.open(ARGV[1], "w")
writer.write(decrypted[:decryption])
puts "Created '#{ARGV[1]}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
writer.close
