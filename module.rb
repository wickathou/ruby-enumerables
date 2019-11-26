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

    arr = []
    my_each { |x| arr.push(x) if yield(x) } if block_given?
    arr
  end

  def my_all?(val = nil)
    arr = to_a.dup
    if block_given?
      my_each { |x| return false unless yield(x) }
      return true
    end
    if val.is_a? Regexp
      my_each { |x| return false unless val.match?(x.to_s) }
      return true
    end
    check_all(arr, val)
  end

  def check_all(arr, val)
    if val.is_a? Class
      arr.my_each { |x| return false unless x.is_a?(val) }
      return true
    end
    if val
      arr.my_each { |x| return false unless x == val }
      return true
    end
    arr.my_each { |x| return false unless x }
    true
  end

  def my_any?(val = nil)
    arr = to_a.dup
    if block_given?
      my_each { |x| return true if yield(x) }
      return false
    end
    if val.is_a? Regexp
      arr.my_each { |x| return true if val.match?(x.to_s) }
      return false
    end
    check_any(arr, val)
  end

  def check_any(arr, val)
    if val.is_a? Class
      arr.my_each { |x| return true if x.is_a?(val) }
      return false
    elsif val
      arr.my_each { |x| return true if x == val }
      return false
    end
    my_each { |x| return true if x }
    false
  end

  def my_none?(val = nil, &a_block)
    !my_any?(val, &a_block)
  end

  def my_count(val = nil)
    count = 0
    my_each { |x| x == val ? count += 1 : count } if a
    return count = size unless block_given?

    my_each { |x| yield(x) ? count += 1 : count } if block_given?
    count
  end

  def my_map
    arr = []
    return to_enum unless block_given?

    my_each { |x| arr.push(yield(x)) } if block_given?
    arr
  end

  def my_inject(val = nil, sym = nil)
    arr = to_a.dup
    final = final_value(val, sym)
    sym = val if val.is_a?(Symbol)
    if sym.is_a?(Symbol)
      arr.my_each { |y| final = final.send(sym, y) }
      return final
    end
    final = 1 if yield(final, arr[0]).zero? && !arr[0].zero?
    arr.my_each { |x| final = yield(final, x) } if block_given?
    final
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
