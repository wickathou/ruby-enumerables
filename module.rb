# frozen_string_literal: true

module Enumerable
  def my_each
    for i in 0...size
      yield(self[i])
    end if block_given?
    to_enum unless block_given?
  end

  def my_each_with_index
    for i in 0...size
      yield(i)
    end if block_given?
    to_enum unless block_given?
  end

  def my_select
    arr = []
    my_each { |x| return arr.push(x) if yield(x) } if block_given?
    to_enum unless block_given?
  end

  def my_all?(a=nil)
    my_each { |x| return yield(x) ? true : false } if block_given?
    my_each { |x| return x.to_s.match?(a) ? true : false } if a.class == Regexp
    my_each { |x| return x.is_a?(a) ? true : false } if a.class == Class
    my_each { |x| return x ? true : false } unless block_given?
  end

  def my_any?(a=nil)
    my_each { |x| return yield(x) ? true : false } if block_given?
    my_each  { |x| return a.match(x.to_s) ? true : false } if a.class == Regexp
    my_each  { |x| return x.is_a?(a) ? true : false } if a.class == Class
    my_each { |x| return x ? true : false } unless block_given?
  end

  def my_none?(a=nil)
    my_each { |x| return yield(x) ? true : false } if block_given?
    my_each { |x| return x.to_s.match(a) ? true : false } if a.class == Regexp
    my_each { |x| return x.is_a?(a) ? true : false } if a.class == Class
    my_each { |x| x ? true : false } unless block_given?
  end

  def my_count(a=nil)
    count = 0
    my_each { |x| yield(x) ? count += 1 : count } if block_given?
    my_each { |x| x == a ? count += 1 : count } if a
    return count if block_given?

    count = size unless block_given?
  end

  def my_map
    arr = []
    my_each { |x| arr.push(yield(x)) } if block_given?
    return arr if block_given?

    to_enum unless block_given?
  end

  def my_inject(a=nil,b=nil)
    a.class == Numeric ? final = a : final = 0
    b = a if a != nil && b.nil?
    if b != nil || b != false
      case b
      when :+
        my_each { |y| final += y }
        return final
      when :-
        my_each { |y| final -= y }
        return final
      when :*
        final = 1 if final != 0
        my_each { |y| final*=y }
        return final
      when :/
        my_each { |y| final /= y }
        return final
      end
    end
    if block_given?
      final = 1 if yield(final, self[0]) == 0 || yield(final, self[1]) == 0 if self[1] != nil
      my_each { |x| final = yield(final, x) }
      return final
    end
  end
end

def multiply_els(x)
  x.my_inject(:+)
end