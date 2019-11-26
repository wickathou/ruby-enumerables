# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    for i in 0...size
      yield(self[i])
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    for i in 0...size
      yield(self[i], i)
    end
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each { |x| arr.push(x) if yield(x) }
    arr
  end

  def my_all?(a = nil)
    to_a if is_a?(Range)
    my_each { |x| return false if yield(x) } if block_given?
    if a.is_a? Regexp
      my_each { |x| return false unless a.match?(x.to_s) }
      return true
    end
    if a.is_a? Class
      my_each { |x| return false unless x.is_a?(a) }
      return true
    end
    if a
      my_each { |x| return false unless x == a }
    end
    my_each { |x| return false unless x }
    true
  end

  def my_any?(a = nil)
    to_a if is_a?(Range)
    if block_given?
      my_each { |x| return true if yield(x) }
      return false
    end
    if a.is_a? Regexp
      my_each { |x| return true if a.match?(x.to_s) }
      return false
    end
    if a.is_a? Class
      my_each { |x| return true if x.is_a?(a) }
      return false
    end
    if a
      my_each { |x| return true if x == a }
      return false
    end
    my_each { |x| return true if x }
    false
  end

  def my_none?(a = nil, &a_block)
    !my_any?(a, &a_block)
  end

  def my_count(a = nil)
    count = 0
    return count = size unless block_given? || !a.nil?

    my_each { |x| yield(x) ? count += 1 : count } if block_given?
    my_each { |x| x == a ? count += 1 : count } if !a.nil? && !block_given?
    count
  end

  def my_map
    arr = []
    return to_enum unless block_given?

    if block_given?
      my_each { |x| arr.push(yield(x)) }
      return arr
    end
  end

  def my_inject(a = nil, b = nil)
    arr = to_a.dup
    a.is_a?(Numeric) ? final = a : final = 0
    b = a if !a.nil? && b.nil?
    if !b.nil? || b != false
      case b
      when :+
        arr.my_each { |y| final += y }
        return final
      when :-
        arr.my_each { |y| final -= y }
        return final
      when :*
        final = 1 unless a.is_a?(Numeric)
        arr.my_each { |y| final *= y }
        return final
      when :/
        arr.my_each { |y| final /= y }
        return final
      end
    end
    final = 1 if yield(final, arr[0]).zero? && !arr[0].zero?
    arr.my_each { |x| final = yield(final, x) } if block_given?
    final
  end

  def multiply_els(x)
    x.my_inject(:*)
  end
end
