require_relative '../lib/module_addons'

module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < size
        if is_a?(Array)
          yield(self[i])
          i += 1
        elsif is_a?(Hash)
          yield(self[keys[i]])
          i += 1
        end
      end
    end
    return to_enum unless block_given?
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < size
        if is_a?(Array)
          yield(self[i], i)
          i += 1
        elsif is_a?(Hash)
          yield(self[keys[i]], i)
          i += 1
        end
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

  def my_none?(val = nil, &a_block)
    !my_any?(val, &a_block)
  end

  def my_count(val = nil)
    count = 0
    if val
      my_each { |x| x == val ? count += 1 : count }
    elsif block_given?
      my_each { |x| yield(x) ? count += 1 : count } if block_given?
    else
      count = size
    end
    count
  end

  def my_map
    arr = []
    return to_enum unless block_given?

    my_each { |x| arr.push(yield(x)) } if block_given?
    arr
  end

  def my_inject(arg1 = nil, arg2 = nil)
    arg1.is_a?(Symbol) ? sym = arg1 : val = arg1
    sym = arg2 if arg2
    arr = to_a.dup
    final = val || arr.shift
    if block_given?
      arr.my_each { |x| final = yield(final, x) }
    elsif sym
      arr.my_each { |y| final = final.send(sym, y) }
    end
    final
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
