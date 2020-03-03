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


  def encrypt(message, key_code = "0" + create_random_num(4), date = @date)
    assign_keys(key_code)
    assign_offsets(date)
    create_shifts
    {encryption: shift_letters(message.strip.downcase), key: key_code, date: date}
  end

  def decrypt(cipher_text, key_code, date = @date)
    assign_keys(key_code)
    assign_offsets(date)
    create_shifts
    reverse_shifts
    {decryption: shift_letters(cipher_text), key: key_code, date: date}
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
    @shifts
  end

  def reverse_shifts
    create_shifts.each do |phase, shift|
      @shifts[phase] = shift - (shift * 2)
    end
    @shifts
  end

  def shift_letters(message)
    message.chars.each_with_index do |letter, index|
      if char_set.include?(letter)
        single_shift(letter, shifts[:A]) if index % 4 == 0
        single_shift(letter, shifts[:B]) if index % 4 == 1
        single_shift(letter, shifts[:C]) if index % 4 == 2
        single_shift(letter, shifts[:D]) if index % 4 == 3
      else
        letter = letter
      end
    end.join
  end

  def single_shift(letter, shift_phase)
    new_index = char_set.find_index(letter) + shift_phase
    letter.tr!(letter, char_set[new_index % 27])
  end
end
