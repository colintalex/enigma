require_relative 'module/timeable'

class Enigma < CipherEngine
  include Timeable

  attr_reader :keys, :offets, :date
  def initialize
    @keys = 0
    @offets = 0
    @date = todays_date_ddmmyy
    super
  end


  def encrypt(message, key_code = 00000, date = @date)

  end
end
