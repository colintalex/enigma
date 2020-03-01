require_relative 'module/timeable'

class Enigma < CipherEngine
  include Timeable

  attr_reader :keys, :offsets, :date
  def initialize
    @keys = {}
    @offsets = {}
    @date = todays_date_ddmmyy
    @shifts = {:A_shift => [], :B_shift => [], :C_shift => [], :D_shift => [],}
    super
  end


  def encrypt(message, key_code = create_random_num, date = @date)
    assign_keys(key_code)
    date_code(date)
  end

  def assign_keys(key_code)
    split_code = key_code.chars.map { |char| char.to_i}
    @keys[:A] = split_code[0] + split_code[1]
    @keys[:B] = split_code[1] + split_code[2]
    @keys[:C] = split_code[2] + split_code[3]
    @keys[:D] = split_code[3] + split_code[4]
  end

  def assign_offsets(date)
    num_date = ((date.to_i)**2).digits.reverse
    @offsets[:D] = num_date.pop
    @offsets[:C] = num_date.pop
    @offsets[:B] = num_date.pop
    @offsets[:A] = num_date.pop
  end
end
