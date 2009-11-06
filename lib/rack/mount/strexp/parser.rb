#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.6
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'rack/mount/strexp/tokenizer'
module Rack
  module Mount
    class StrexpParser < Racc::Parser
##### State transition tables begin ###

racc_action_table = [
     1,     2,     3,     9,     4,     1,     2,     3,    12,     4,
     1,     2,     3,    11,     4,     1,     2,     3,   nil,     4 ]

racc_action_check = [
     0,     0,     0,     5,     0,     3,     3,     3,     9,     3,
     8,     8,     8,     8,     8,     6,     6,     6,   nil,     6 ]

racc_action_pointer = [
    -2,   nil,   nil,     3,   nil,     3,    13,   nil,     8,     8,
   nil,   nil,   nil ]

racc_action_default = [
    -8,    -4,    -5,    -8,    -7,    -8,    -1,    -3,    -8,    -8,
    -2,    -6,    13 ]

racc_goto_table = [
     6,     5,    10,     8,    10 ]

racc_goto_check = [
     2,     1,     3,     2,     3 ]

racc_goto_pointer = [
   nil,     1,     0,    -4 ]

racc_goto_default = [
   nil,   nil,   nil,     7 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 8, :_reduce_1,
  2, 9, :_reduce_2,
  1, 9, :_reduce_none,
  1, 10, :_reduce_4,
  1, 10, :_reduce_5,
  3, 10, :_reduce_6,
  1, 10, :_reduce_7 ]

racc_reduce_n = 8

racc_shift_n = 13

racc_token_table = {
  false => 0,
  :error => 1,
  :PARAM => 2,
  :GLOB => 3,
  :LPAREN => 4,
  :RPAREN => 5,
  :CHAR => 6 }

racc_nt_base = 7

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
  "PARAM",
  "GLOB",
  "LPAREN",
  "RPAREN",
  "CHAR",
  "$start",
  "target",
  "expr",
  "token" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

def _reduce_1(val, _values, result)
 result = "\\A#{val.join}\\Z" 
    result
end

def _reduce_2(val, _values, result)
 result = val.join 
    result
end

# reduce 3 omitted

def _reduce_4(val, _values, result)
           name = val[0].to_sym
           requirement = requirements[name]
           result = Const::REGEXP_NAMED_CAPTURE % [name, requirement]
         
    result
end

def _reduce_5(val, _values, result)
           name = val[0].to_sym
           result = Const::REGEXP_NAMED_CAPTURE % [name, '.+']
         
    result
end

def _reduce_6(val, _values, result)
 result = "(#{val[1]})?" 
    result
end

def _reduce_7(val, _values, result)
 result = Regexp.escape(val[0]) 
    result
end

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class StrexpParser
    end   # module Mount
  end   # module Rack