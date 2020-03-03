require 'Simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'

require_relative '../lib/cipher_engine'
require_relative '../lib/enigma'
require_relative '../lib/module/timeable'
