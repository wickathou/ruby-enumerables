# frozen_string_literal: true

module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < size
        yield(self[i])
        i += 1
      end
    end
    return to_enum unless block_given?
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
    end
    return to_enum unless block_given?
  end

  def my_select
    return to_enum unless block_given?
    if block_given?
      arr = []
      my_each { |x| arr.push(x) if yield(x) }
      arr
    end
  end

  def my_all?(a = nil)
    arr = to_a.dup
    if block_given?
      my_each { |x| return false unless yield(x) }
      return true
    end
    if a.is_a? Regexp
      my_each { |x| return false unless a.match?(x.to_s) }
      return true
    end
    return check_all(arr, a)
  end

  def check_all(arr, a)
    if a.is_a? Class
      arr.my_each { |x| return false unless x.is_a?(a) }
      return true
    end
    if a
      arr.my_each { |x| return false unless x == a }
      return true
    end
    arr.my_each { |x| return false unless x }
    return true
  end

  def my_any?(a = nil)
    arr = to_a.dup
    if block_given?
      my_each { |x| return true if yield(x) }
      return false
    end
    if a.is_a? Regexp
      arr.my_each { |x| return true if a.match?(x.to_s) }
      return false
    end
    return check_any(arr, a)
  end

  def check_any(arr, a)
    if a.is_a? Class
      arr.my_each { |x| return true if x.is_a?(a) }
      return false
    elsif a
      arr.my_each { |x| return true if x == a }
      return false
    else
      my_each { |x| return true if x }
      return false
    end
  end

  def my_none?(a = nil, &a_block)
    !my_any?(a, &a_block)
  end

  def my_count(a = nil)
    count = 0
    my_each { |x| x == a ? count += 1 : count } if a
    return count = size unless block_given?
    my_each { |x| yield(x) ? count += 1 : count } if block_given?
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
    final = final_value(a, b)
    b = a if a.is_a?(Symbol)
    if b.is_a?(Symbol)
      arr.my_each {|y| final = final.send(b,y)}
      return final
    end
    if block_given?
      final = 1 if yield(final, arr[0]).zero? && !arr[0].zero?
      arr.my_each { |x| final = yield(final, x) }
      final
    end
  end

  def final_value(val, sym)
    return val if val.is_a?(Numeric)
    
    if val == :* || sym == :*
      1
    else
      0
    end
  end

  def multiply_els(arr)
    final = 1
    arr.my_each { |y| final *= y }
    final
  end
end
