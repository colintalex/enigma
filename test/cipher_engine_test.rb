require './test/test_helper'
require './lib/cipher_engine'

class CipherEngineTest < Minitest::Test

  def setup
    @cipher_engine = CipherEngine.new
  end

  def test_it_exists
    assert_instance_of CipherEngine, @cipher_engine
  end

  def test_it_can_return_todays_date
    require "pry"; binding.pry
    assert_equal 0 ,@cipher_engine.todays_date_ddmmyy
  end
end
