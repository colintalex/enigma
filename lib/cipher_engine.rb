class CipherEngine

  attr_reader :char_set
  def initialize
    @char_set = []
  end

  def create_char_set(additional_char = nil)
    if additional_char != nil
      @char_set = ("a".."z").to_a << additional_char
    else
      @char_set = ("a".."z").to_a
    end
  end

  def create_random_num(num_digits)
    random_digits = []
    num_digits.times do
      random_digits << Random.rand(10)
    end
    random_digits.join
  end
end
