require_relative 'test_helper'

class EnigmaTest < Minitest::Test
  include Timeable
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    expected = {}
    assert_equal expected, @enigma.keys
    assert_equal expected, @enigma.offsets
    assert_equal todays_date_ddmmyy, @enigma.date
  end

  def test_assign_keys
    expected = {A:3,B:11,C:13,D:9}
    @enigma.assign_keys("03854")
    assert_equal expected, @enigma.keys
  end

  def test_assign_offsets
    Time.stubs(:now).returns([1, 1, 1, 6, 3, 2017, 1, 1])
    assert_equal "060317", todays_date_ddmmyy
    @enigma.assign_offsets(todays_date_ddmmyy)
    
    expected = {A:0,B:4,C:8,D:9}
    assert_equal expected, @enigma.offsets
  end

  def test_encrypt
    skip
    expected = { encryption: "keder ohulw",
                key: "02715",
                date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end
end
