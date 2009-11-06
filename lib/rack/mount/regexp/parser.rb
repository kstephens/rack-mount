#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.6
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'rack/mount/regexp/tokenizer'

module Rack
  module Mount
    class RegexpParser < Racc::Parser


class Node < Struct.new(:left, :right)
  def flatten
    if left.is_a?(Node)
      left.flatten + [right]
    else
      [left, right]
    end
  end
end

class Expression < Array
  def initialize(ary)
    if ary.is_a?(Node)
      super(ary.flatten)
    else
      super([ary])
    end
  end
end

class Group < Struct.new(:value)
  attr_accessor :quantifier, :capture, :name

  def initialize(*args)
    @capture = true
    super
  end

  def capture?
    capture
  end

  def ==(other)
    self.value == other.value &&
      self.quantifier == other.quantifier &&
      self.capture == other.capture &&
      self.name == other.name
  end
end

class CharacterRange < Struct.new(:value)
  attr_accessor :quantifier

  def ==(other)
    self.value == other.value &&
      self.quantifier == other.quantifier
  end
end

class Character < Struct.new(:value)
  attr_accessor :quantifier

  def ==(other)
    self.value == other.value &&
      self.quantifier == other.quantifier
  end
end
##### State transition tables begin ###

racc_action_table = [
     6,     7,    22,    23,     8,    14,    17,    15,    12,    13,
     6,     7,     6,     7,     8,    21,     8,     6,     7,     6,
     7,     8,    14,     8,    18,    12,    13,    20,     9,    26,
    27 ]

racc_action_check = [
     8,     8,    17,    17,     8,     3,     8,     7,     3,     3,
     2,     2,    23,    23,     2,    16,    23,    22,    22,     0,
     0,    22,    10,     0,     9,    10,    10,    15,     1,    24,
    25 ]

racc_action_pointer = [
    17,    28,     8,    -3,   nil,   nil,   nil,     3,    -2,    24,
    14,   nil,   nil,   nil,   nil,    22,     8,    -7,   nil,   nil,
   nil,   nil,    15,    10,    22,    23,   nil,   nil ]

racc_action_default = [
   -16,   -16,    -1,    -5,    -6,    -7,    -8,   -16,   -16,   -16,
    -3,    -4,   -13,   -14,   -15,   -16,   -16,   -16,    28,    -2,
    -9,   -10,   -16,   -16,   -16,   -16,   -11,   -12 ]

racc_goto_table = [
     1,    10,    11,   nil,   nil,   nil,   nil,   nil,    16,    19,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    24,    25 ]

racc_goto_check = [
     1,     3,     4,   nil,   nil,   nil,   nil,   nil,     1,     4,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,     1,     1 ]

racc_goto_pointer = [
   nil,     0,   nil,    -1,    -1,   nil,   nil ]

racc_goto_default = [
   nil,   nil,     2,     3,   nil,     4,     5 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 14, :_reduce_1,
  3, 15, :_reduce_2,
  2, 15, :_reduce_3,
  2, 15, :_reduce_4,
  1, 15, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_none,
  1, 16, :_reduce_8,
  3, 19, :_reduce_9,
  3, 18, :_reduce_10,
  5, 18, :_reduce_11,
  5, 18, :_reduce_12,
  1, 17, :_reduce_none,
  1, 17, :_reduce_none,
  1, 17, :_reduce_none ]

racc_reduce_n = 16

racc_shift_n = 28

racc_token_table = {
  false => 0,
  :error => 1,
  :CHAR => 2,
  :LBRACK => 3,
  :RANGE => 4,
  :RBRACK => 5,
  :LPAREN => 6,
  :RPAREN => 7,
  :QMARK => 8,
  :COLON => 9,
  :NAME => 10,
  :STAR => 11,
  :PLUS => 12 }

racc_nt_base = 13

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "CHAR",
  "LBRACK",
  "RANGE",
  "RBRACK",
  "LPAREN",
  "RPAREN",
  "QMARK",
  "COLON",
  "NAME",
  "STAR",
  "PLUS",
  "$start",
  "expression",
  "branch",
  "atom",
  "quantifier",
  "group",
  "bracket_expression" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

def _reduce_1(val, _values, result)
 result = Expression.new(val[0]) 
    result
end

def _reduce_2(val, _values, result)
            val[1].quantifier = val[2]
            result = Node.new(val[0], val[1])
          
    result
end

def _reduce_3(val, _values, result)
 result = Node.new(val[0], val[1]) 
    result
end

def _reduce_4(val, _values, result)
            val[0].quantifier = val[1]
            result = val[0]
          
    result
end

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

def _reduce_8(val, _values, result)
 result = Character.new(val[0]) 
    result
end

def _reduce_9(val, _values, result)
 result = CharacterRange.new(val[1]) 
    result
end

def _reduce_10(val, _values, result)
 result = Group.new(val[1]) 
    result
end

def _reduce_11(val, _values, result)
 result = Group.new(val[3]); result.capture = false 
    result
end

def _reduce_12(val, _values, result)
 result = Group.new(val[3]); result.name = val[2] 
    result
end

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class RegexpParser
    end   # module Mount
  end   # module Rack
