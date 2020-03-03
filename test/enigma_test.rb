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

    expected_1 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                  "y", "z"]
    expected_2 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                  "y", "z", " "]
    assert_equal expected_1, @enigma.create_char_set
    assert_equal expected_2, @enigma.create_char_set(" ")
  end

  def test_assign_keys
    expected = {A:3,B:31,C:16,D:64}
    @enigma.assign_keys("03164")
    assert_equal expected, @enigma.keys
  end

  def test_assign_offsets
    Time.stubs(:now).returns([1, 1, 1, 6, 3, 2017, 1, 1])
    assert_equal "060317", todays_date_ddmmyy
    @enigma.assign_offsets(todays_date_ddmmyy)

    expected = {A:0,B:4,C:8,D:9}
    assert_equal expected, @enigma.offsets
  end

  def test_create_shifts
    @enigma.assign_keys("02549")
    @enigma.assign_offsets("060317")
    @enigma.create_shifts
    expected = {:A=>2, :B=>29, :C=>62, :D=>58}
    assert_equal expected, @enigma.shifts
  end

  def test_create_reverse_shifts
    @enigma.assign_keys("02549")
    @enigma.assign_offsets("060317")
    @enigma.reverse_shifts
    expected = {:A=>-2, :B=>-29, :C=>-62, :D=>-58}
    assert_equal expected, @enigma.shifts
  end

  def test_single_shift
    @enigma.stubs(:shifts).returns({A:1,B:1,C:1,D:1})
    assert_equal 'b', @enigma.single_shift('a', @enigma.shifts[:A])
    assert_equal ' ', @enigma.single_shift('z', @enigma.shifts[:A])
    assert_equal 'a', @enigma.single_shift(' ', @enigma.shifts[:A])
  end

  def test_shift_letters
    @enigma.create_char_set(" ")
    @enigma.stubs(:shifts).returns({A:1,B:2,C:3,D:4})
    assert_equal "igopp", @enigma.shift_letters("hello")
    assert_equal "igoppbzssng", @enigma.shift_letters("hello world")
  end

  def test_encrypt
    expected = { encryption: "keder ohulw",
                key: "02715",
                date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_decrypt
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_doesnt_encrypt_special_characters
    encrypted = @enigma.encrypt("hello?world!", "02715", "040895")
    decrypted = @enigma.decrypt(encrypted[:encryption], "02715", "040895")
    assert_equal "hello?world!", decrypted[:decryption]
  end

  def test_encrypt_with_current_date
    encrypted = @enigma.encrypt("hello world", "02715")
    decrypted = @enigma.decrypt(encrypted[:encryption], "02715")
    assert_equal "hello world", decrypted[:decryption]
  end

  def test_encrypt_with_message_only
    encrypted = @enigma.encrypt("hello world")
    decrypted = @enigma.decrypt(encrypted[:encryption], encrypted[:key], encrypted[:date])
    assert_equal "hello world", decrypted[:decryption]
  end
end
