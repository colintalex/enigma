require './test/test_helper'

class CipherEngineTest < Minitest::Test
  def setup
    @cipher_engine = CipherEngine.new
  end

  def test_it_exists
    assert_instance_of CipherEngine, @cipher_engine
  end

  def test_it_can_create_charsets_with_extra_chars
    expected = ("a".."z").to_a
    expected_1 = ("a".."z").to_a << " "
    assert_equal expected, @cipher_engine.create_char_set
    assert_equal expected_1, @cipher_engine.create_char_set(' ')
  end

  def test_random_number_generator
    num = "1234"
    assert_equal num.size, @cipher_engine.create_random_num(4).size
    num_1 = "12345"
    assert_equal num_1.size, @cipher_engine.create_random_num(5).size
  end
end
