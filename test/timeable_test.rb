require './test/test_helper'

class TimeDateTest < Minitest::Test
  include Timeable

    def test_module_can_return_todays_date
      Time.stubs(:now).returns([1, 1, 1, 6, 3, 2017, 1, 1])
      assert_equal "060317", todays_date_ddmmyy
    end
end
