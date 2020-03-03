require_relative 'cipher_engine'
require_relative 'module/timeable'

class Enigma < CipherEngine
  include Timeable

  attr_reader :keys, :offsets, :date, :shifts
  def initialize
    @keys = {}
    @offsets = {}
    @date = todays_date_ddmmyy
    @shifts = {}
    super
    create_char_set(" ")
  end


  def encrypt(message, key_code = create_random_num(5), date = @date)
    assign_keys(key_code)
    assign_offsets(date)
    create_shifts
    {encryption: shift_letters(message), key: key_code, date: date}
  end

  def assign_keys(key_code)
    split_code = key_code.chars.map { |char| char.to_i}
    @keys[:A] = (split_code[0].to_s + split_code[1].to_s).to_i
    @keys[:B] = (split_code[1].to_s + split_code[2].to_s).to_i
    @keys[:C] = (split_code[2].to_s + split_code[3].to_s).to_i
    @keys[:D] = (split_code[3].to_s + split_code[4].to_s).to_i
    @keys
  end

  def assign_offsets(date)
    num_date = ((date.to_i)**2).digits.reverse
    @offsets[:D] = num_date.pop
    @offsets[:C] = num_date.pop
    @offsets[:B] = num_date.pop
    @offsets[:A] = num_date.pop
    @offsets
  end

  def create_shifts
    @keys.each do |key, value|
      @shifts[key] = @offsets[key] + value
    end
  end

  def shift_letters(message)
    index = ['a', 'b', 'c', 'd']
    z = message.chars.map do |letter|
      if index.first == 'a'
        index.rotate!
        new_index = char_set.find_index(letter) + shifts[:A]
        letter.tr!(letter, char_set[new_index % 27])
      elsif index.first == 'b'
        index.rotate!
        new_index = char_set.find_index(letter) + shifts[:B]
        letter.tr!(letter, char_set[new_index % 27])
      elsif index.first == 'c'
        index.rotate!
        new_index = char_set.find_index(letter) + shifts[:C]
        letter.tr!(letter, char_set[new_index % 27])
      elsif index.first == 'd'
        index.rotate!
        new_index = char_set.find_index(letter) + shifts[:D]
        letter.tr!(letter, char_set[new_index % 27])
      end
    end.join
  end
end
