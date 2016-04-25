# Don't write comments, consider refactoring the code to be more expressive.
# If something needs explanation, add it to the README with a code example.
class ExampleClass
  extend First
  include Second

  ThenAnyErrorClass = Class.new(StandardError)

  attr_reader :stuff, :things
  private :stuff, :things

  def initialize(stuff, things)
    @stuff, @things = stuff, things
  end

  def self.define_public_class_methods_below_initialize
    and_before_instance_methods
  end

  class << self
    attr_reader :class_instance_variables
    attr_writer :but_prefer_not_to
  end

  def use_lazy_evaluation
    @prefer ||= lazy_evaluation_over_work_in_the_initializer
  end

  def except_for_boolean_values
    @false_would_always_become ||= true
  end

  def method_without_args
    omit_parentheses
  end

  def methods_with_args(prefer_none, fewer_is_better)
    include_parentheses(three_args_is_probably_too_many)
  end

  def keep_methods_short
    prefer_a_single_line
  end

  def keep_longer_methods_well_spaced
    prefer_a_single_line
    but_if_not

    leave_a_line_before_the_return_value
  end

  def limit_lines_to_eighty_characters
    when_chaining_methods_that_run_longer_than_eighty_characters.
      indent_the_second_line
  end

  def for_methods_with_args(one, two)
    prefer_no_optional_args
  end

  def for_methods_with_optional_args(one, two: :default)
    prefer_keyword_args * where_available
  end

  def calling_methods_with_many_args
    Where.calling_methods_with_args_that_would_run_over_eighty_characters(
      split_over,
      multiple_lines,
      omit: 'braces_on_options'
    )
  end

  def use_spaces_around_operators
    array.each { |item| puts item }
  end

  def underscore_unused_block_args
    hash.delete_if { |_, value| value.nil? }
  end

  def use_stabby_lambdas
    ->(one, two) { one + two }
  end

  def except_when_over_multiple_lines
    lambda do |one, two|
      so_many_lines
      one + two
    end
  end

  def call_lambdas_with_call
    not_dot_or_square_brackets.call(1,2)
  end

  def do_not_use_call_for_blocks(&block)
    block.call
  end

  def use_yield_instead
    yield if block_given?
  end

  def use_curly_bracket_syntax_where_we_care_about_the_return_value
    changed_things = things.map { |thing| thing.change_with(argument) }
  end

  def or_where_the_block_fits_on_a_single_line
    things.each { |thing| thing.stuff_with!(argument) }
  end

  def use_symbol_to_proc_syntax_for_methods_without_args
    new_things = things.map(&:new?)
  end

  def use_do_end_syntax_where_the_block_does_not_fit_on_a_single_line
    things.each do |thing|
      thing.stuff!
      thing.more_stuff!
    end
  end

  def prefer_literal_hash_with_one_nine_syntax
    { one: 1, two: 2, three: 3 }
  end

  def split_many_keys_over_multiple_lines_with_a_trailing_comma
    {
      one: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
    }
  end

  def always_use_fetch
    hash.fetch(:one)
  end

  def only_set_a_default_where_appropriate
    hash.fetch(:one, 1)
  end

  def use_block_syntax_for_errors
    hash.fetch(:one) { fail "It's not working" }
  end

  def prefer_literal_arrays_with_spaces
    [1, 2, 3]
  end

  def split_many_values_over_multiple_lines_with_a_trailing_comma
    [
      one,
      two,
      three,
      four,
      five,
    ]
  end

  def underscore_numbers_for_readability
    1_000_000
  end

  def for_arrays_of_strings
    %w{one two}
  end

  def for_arrays_of_symbols
    %i{one two}
  end

  def prefer_string_literals
    'use single quotes where escaping or interpolation is not required'
  end

  def with_interpolation
    "use double quotes - #{no_spaces_inside_interpolation}"
  end

  def with_double_quotes
    %q{avoid "escaping", always use curly brackets}
  end

  def with_quotes_and_interpolation
    %{avoid "escaping" and #{interpolate} with curly brackets}
  end

  def do_not_use_for
    for leak in array do
      leak(is_available_outside_the_scope)
    end
  end

  def do_not_use_and_for_conditional_logic_use(this: '&&')
    this? && that?
  end

  def do_use_and_for_control_flow
    do_something and return
  end

  def do_not_use_or_for_conditional_logic_use(this: '||')
    this || that
  end

  def do_use_or_for_control_flow
    do_something or fail
  end

  def where_a_variable_may_not_exist_do_not_use_this
    stuff = stuff.things if stuff
  end

  def use_this_instead
    stuff &&= stuff.things
  end

  def prefer_if_else_over_ternary
    if this?
      this
    else
      that
    end
  end

  def prefer_fail_to_raise
    fail ThenAnyErrorClass, 'this is why you fail'
  end

  def except_when_re_raising
    do_something
  rescue ThenAnyErrorClass => error
    log(error)
    raise error
  ensure
    anything_that_absolutely_has_to_happen
  end

  def prefer_methods_for_magic_values
    AS_CONSTANTS = 'can be mutated'
  end

  protected

  def protected_keyword_and_protected_methods
    at_same_indentation
  end

  private

  def private_keyword_and_private_methods
    at_same_indentation
  end

  def keep_the_public_api_slim
    if_it_can_be_private(make_it_private)
  end

end
