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


def parse_regexp(regexp)
  unless regexp.is_a?(RegexpWithNamedGroups)
    regexp = RegexpWithNamedGroups.new(regexp)
  end

  expression = scan_str(regexp.source)
  expression.ignorecase = regexp.casefold?

  unless Const::SUPPORTS_NAMED_CAPTURES
    @capture_index = 0
    tag_captures!(regexp.names, expression)
  end

  expression
rescue Racc::ParseError => e
  puts "Failed to parse #{regexp.inspect}: #{e.message}" if $DEBUG
  raise e
end

def tag_captures!(names, group)
  group.each do |child|
    if child.is_a?(Group)
      if child.capture
        child.name = names[@capture_index]
        @capture_index += 1
      end
      tag_captures!(names, child)
    elsif child.is_a?(Array)
      tag_captures!(names, child)
    end
  end
end


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
  attr_accessor :ignorecase

  def initialize(ary)
    if ary.is_a?(Node)
      super(ary.flatten)
    else
      super([ary])
    end
  end

  def casefold?
    ignorecase
  end
end

class Group < Struct.new(:value)
  attr_accessor :quantifier, :capture, :name

  def initialize(*args)
    @capture = true
    super
  end

  def to_regexp
    value.map { |e| e.regexp_source }.join
  end

  def regexp_source
    "(#{capture ? '' : '?:'}#{value.map { |e| e.regexp_source }.join})#{quantifier}"
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

class Anchor < Struct.new(:value)
end

class CharacterRange < Struct.new(:value)
  attr_accessor :negate, :quantifier

  def regexp_source
    if value == '.' || value == '\d'
      "#{value}#{quantifier}"
    else
      "[#{negate && '^'}#{value}]#{quantifier}"
    end
  end

  def include?(char)
    Regexp.compile("^#{regexp_source}$") =~ char.to_s
  end

  def ==(other)
    self.value == other.value &&
      self.negate == other.negate &&
      self.quantifier == other.quantifier
  end
end

class Character < Struct.new(:value)
  attr_accessor :quantifier

  def regexp_source
    "#{value}#{quantifier}"
  end

  def ==(other)
    self.value == other.value &&
      self.quantifier == other.quantifier
  end
end
##### State transition tables begin ###

racc_action_table = [
     3,    31,     5,     6,     7,     8,     9,    38,    29,    30,
     3,     2,     5,     6,     7,     8,     9,    37,    33,    28,
     3,     2,     5,     6,     7,     8,     9,    15,    17,    18,
     3,     2,     5,     6,     7,     8,     9,    39,    40,    41,
     3,     2,     5,     6,     7,     8,     9,    14,    24,    42,
    15,     2,    21,    22,    23,    24,   nil,   nil,    25,    21,
    22,    23,    26,    34,   nil,   nil,   nil,    26 ]

racc_action_check = [
     0,    18,     0,     0,     0,     0,     0,    33,    17,    17,
    29,     0,    29,    29,    29,    29,    29,    33,    23,    16,
     9,    29,     9,     9,     9,     9,     9,    14,     9,    10,
    11,     9,    11,    11,    11,    11,    11,    35,    36,    38,
    30,    11,    30,    30,    30,    30,    30,     3,    12,    41,
     3,    30,    12,    12,    12,    19,   nil,   nil,    13,    19,
    19,    19,    13,    27,   nil,   nil,   nil,    27 ]

racc_action_pointer = [
    -2,   nil,   nil,    43,   nil,   nil,   nil,   nil,   nil,    18,
    29,    28,    38,    55,    20,   nil,    10,    -3,     1,    45,
   nil,   nil,   nil,    11,   nil,   nil,   nil,    60,   nil,     8,
    38,   nil,   nil,     0,   nil,    28,    29,   nil,    32,   nil,
   nil,    32,   nil ]

racc_action_default = [
   -25,    -6,   -19,   -25,   -11,   -18,    -9,   -10,   -12,   -25,
   -25,    -1,    -5,   -25,   -25,   -14,   -25,   -25,   -25,    -3,
    -4,   -20,   -21,   -25,   -22,    -7,   -13,   -25,   -15,   -25,
   -25,    43,    -2,   -25,    -8,   -25,   -25,   -24,   -25,   -16,
   -17,   -25,   -23 ]

racc_goto_table = [
    10,    13,    19,    20,   nil,   nil,   nil,   nil,   nil,    16,
    32,   nil,    27,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    35,
    36 ]

racc_goto_check = [
     1,     6,     3,     4,   nil,   nil,   nil,   nil,   nil,     1,
     4,   nil,     6,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     1,
     1 ]

racc_goto_pointer = [
   nil,     0,   nil,    -9,    -9,   nil,    -2,   nil ]

racc_goto_default = [
   nil,   nil,    11,    12,   nil,     1,   nil,     4 ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 19, :_reduce_1,
  3, 20, :_reduce_2,
  2, 20, :_reduce_3,
  2, 20, :_reduce_4,
  1, 20, :_reduce_none,
  1, 21, :_reduce_none,
  3, 21, :_reduce_7,
  4, 21, :_reduce_8,
  1, 21, :_reduce_9,
  1, 21, :_reduce_10,
  1, 21, :_reduce_11,
  1, 21, :_reduce_12,
  2, 24, :_reduce_13,
  1, 24, :_reduce_none,
  3, 23, :_reduce_15,
  5, 23, :_reduce_16,
  5, 23, :_reduce_17,
  1, 25, :_reduce_none,
  1, 25, :_reduce_none,
  1, 22, :_reduce_none,
  1, 22, :_reduce_none,
  1, 22, :_reduce_none,
  5, 22, :_reduce_23,
  3, 22, :_reduce_24 ]

racc_reduce_n = 25

racc_shift_n = 43

racc_token_table = {
  false => 0,
  :error => 1,
  :LBRACK => 2,
  :RBRACK => 3,
  :L_ANCHOR => 4,
  :CHAR_CLASS => 5,
  :DOT => 6,
  :CHAR => 7,
  :LPAREN => 8,
  :RPAREN => 9,
  :QMARK => 10,
  :COLON => 11,
  :NAME => 12,
  :R_ANCHOR => 13,
  :STAR => 14,
  :PLUS => 15,
  :LCURLY => 16,
  :RCURLY => 17 }

racc_nt_base = 18

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
  "LBRACK",
  "RBRACK",
  "L_ANCHOR",
  "CHAR_CLASS",
  "DOT",
  "CHAR",
  "LPAREN",
  "RPAREN",
  "QMARK",
  "COLON",
  "NAME",
  "R_ANCHOR",
  "STAR",
  "PLUS",
  "LCURLY",
  "RCURLY",
  "$start",
  "expression",
  "branch",
  "atom",
  "quantifier",
  "group",
  "bracket_expression",
  "anchor" ]

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

def _reduce_7(val, _values, result)
 result = CharacterRange.new(val[1])
    result
end

def _reduce_8(val, _values, result)
 result = CharacterRange.new(val[2]); result.negate = true
    result
end

def _reduce_9(val, _values, result)
 result = CharacterRange.new(val[0])
    result
end

def _reduce_10(val, _values, result)
 result = CharacterRange.new(val[0])
    result
end

def _reduce_11(val, _values, result)
 result = Anchor.new(val[0])
    result
end

def _reduce_12(val, _values, result)
 result = Character.new(val[0])
    result
end

def _reduce_13(val, _values, result)
 result = val.join
    result
end

# reduce 14 omitted

def _reduce_15(val, _values, result)
 result = Group.new(val[1])
    result
end

def _reduce_16(val, _values, result)
 result = Group.new(val[3]); result.capture = false
    result
end

def _reduce_17(val, _values, result)
 result = Group.new(val[3]); result.name = val[2]
    result
end

# reduce 18 omitted

# reduce 19 omitted

# reduce 20 omitted

# reduce 21 omitted

# reduce 22 omitted

def _reduce_23(val, _values, result)
 result = val.join
    result
end

def _reduce_24(val, _values, result)
 result = val.join
    result
end

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class RegexpParser
    end   # module Mount
  end   # module Rack
