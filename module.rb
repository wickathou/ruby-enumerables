module Enumerable
  def my_each
    if block_given?
      for i in 0...size
        yield(self[i])
      end
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0...size
        yield(i)
      end
    else
      to_enum
    end
  end

  def my_select
    arr = []
    if block_given?
      my_each do |x|
        arr.push(x) if yield(x)
      end
      return arr
    else
      to_enum
    end
  end
  
  def my_all?(a=nil)
    if block_given?
      my_each do |x|
        false if yield(x).nil? || yield(x) == false
      end
      true
    elsif a
      if a.class == Regexp
        my_each do |x|
          return false if a.match(x.to_s).nil? || a.match(x.to_s) == false
        end
        true
      elsif a.class == Class
        my_each do |x|
          return false if x.is_a?(a).nil? || x.is_a?(a) == false
        end
        true
      end
    else
      my_each do |x|
        false if x.nil? || x == false
      end
      true
    end
  end

  def my_any?(a=nil)
    if block_given?
      my_each do |x|
        true if yield(x) == true
      end
      false
    elsif a
      if a.class == Regexp
        my_each do |x|
          return true if a.match(x.to_s)
        end
        false
      elsif a.class == Class
        my_each do |x|
          true if x.is_a?(a) == true
        end
        false

      end
    else
      my_each do |x|
        true if x
      end
      false
    end
  end

  def my_none?(a=nil)
    if block_given?
      my_each do |x|
         if yield(x) == false || yield(x).nil?
        return true
         end
      end
      false
    elsif a
      if a.class == Regexp
        my_each do |x|
          if  a.match(x.to_s).nil? || a.match(x.to_s) == false
            return true
          end
        end
        false
      elsif a.class == Class
        my_each do |x|
          if  x.is_a?(a).nil? || x.is_a?(a) == false
            return true
          end
        end
        false

      end
    else
      my_each do |x|
         if x.nil? || x == false
        return true
         end
      end
      false
    end
  end

  def my_count(a=nil)
    count = 0
    if block_given?
      my_each {|x| yield(x) ? count+=1 : count}
      return count
    elsif a
      my_each {|x| x == a ? count+=1 : count}
      return count
    else
      count = size
    end
  end

  def my_map
    if block_given?
      arr = []
      my_each do |x|
        arr.push(yield(x))
      end
      arr
    else
      to_enum
    end
  end

  def my_inject(a=nil,b=nil)
    a.class == Numeric ? final = a : final = 0
    if a != nil && b.nil?
      b = a
    end
    if b != nil || b != false
      case b
      when :+
        my_each {|y| final+=y}
        return final
      when :-
        my_each {|y| final-=y}
        return final
      when :*
        final = 1 if final != 0
        my_each {|y| final*=y}
        return final
      when :/
        my_each {|y| final/=y}
        return final
      end
    end
    if block_given?
      final = 1 if yield(final, self[0]) == 0 || yield(final, self[1]) == 0 if self[1] != nil
      my_each {|x| final = yield(final,x)}
      return final
    end
  end

  

end

def multiply_els(x)
  x.my_inject(:+)
end

some = [1,2,3]

# Tests

# multiply_els

puts multiply_els(some)

# Map with block and with proc

some.my_map{|a| a*2}

some_proc = Proc.new{|a| a*2}

some.my_map(&some_proc)

# my_each test

some.my_each{|x| puts x}

some.my_each

# my_each_with_index test

some.my_each_with_index{|x| puts x}

puts some.my_each_with_index

# my_select test

puts some.my_select{|a| a%2==0}

# my_all? test

puts some.my_all?{|a| a%2==0}

puts some.my_all?(/\d/)

puts some.my_all?(String)

# my_any? test

puts some.my_any?{|a| a%2==0}

puts some.my_any?(/\d/)

puts some.my_any?(String)

# my_none? test

puts some.my_none?{|a| a%5==0}

puts some.my_none?(/\W/)

puts some.my_none?(String)

# my_count test

puts some.my_count(1)

puts some.my_count

puts some.my_count{|a| a%1==0}

# my_inject test

puts some.my_inject{|x,y| x*y}

puts some.my_inject(:+)

puts some.my_inject(1){|x,y| x+y}