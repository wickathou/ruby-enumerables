module Enumerable
    def my_each
        if block_given?
            for i in 0...self.size
                yield(self[i])
            end
        else
            self.to_enum
        end
    end

    def my_each_with_index
        if block_given?
            for i in 0...self.size
                yield(i)
            end
        else
            self.to_enum
        end
    end

    def my_select
        arr = []
        if block_given?
            self.my_each do |x|
                if yield(x)
                    arr.push(x)
                end
            end
            return arr
        else
            self.to_enum
        end
    end
    
    def my_all?(a=nil)
        if block_given?
            self.my_each do |x|
               if yield(x) == nil || yield(x) == false
                return false
               end
            end
            true
        elsif a
            if a.class == Regexp
                self.my_each do |x|
                    if  a.match(x.to_s) == nil || a.match(x.to_s) == false
                        return false
                    end
                end
                true
            elsif a.class == Class
                self.my_each do |x|
                    if  x.is_a?(a) == nil || x.is_a?(a) == false
                        return false
                    end
                end
                true

            end
        else
            self.my_each do |x|
               if x == nil || x == false
                return false
               end
            end
            true
        end
    end

    def my_any?(a=nil)
        if block_given?
            self.my_each do |x|
               if yield(x) == true
                return true
               end
            end
            false
        elsif a
            if a.class == Regexp
                self.my_each do |x|
                    if  a.match(x.to_s)
                        return true
                    end
                end
                false
            elsif a.class == Class
                self.my_each do |x|
                    if  x.is_a?(a) == true
                        return true
                    end
                end
                false

            end
        else
            self.my_each do |x|
               if x
                return true
               end
            end
            false
        end
    end

    def my_none?(a=nil)
        if block_given?
            self.my_each do |x|
               if yield(x) == false || yield(x) == nil
                return true
               end
            end
            false
        elsif a
            if a.class == Regexp
                self.my_each do |x|
                    if  a.match(x.to_s) == nil || a.match(x.to_s) == false
                        return true
                    end
                end
                false
            elsif a.class == Class
                self.my_each do |x|
                    if  x.is_a?(a) == nil || x.is_a?(a) == false
                        return true
                    end
                end
                false

            end
        else
            self.my_each do |x|
               if x == nil || x == false
                return true
               end
            end
            false
        end
    end

    def my_count(a=nil)
        count = 0
        if block_given?
            self.my_each {|x| yield(x) ? count+=1 : count}
            return count
        elsif a
            self.my_each {|x| x == a ? count+=1 : count}
            return count
        else
            count = self.size
        end
    end

    def my_map
        if block_given?
            arr = []
            self.my_each do |x|
                arr.push(yield(x))
            end
            arr
        else
            self.to_enum
        end
    end

    def my_inject(a=nil,b=nil)
        a != nil ? final = a : final = 0
        if b != nil || b != false
            case b
            when :+
                self.my_each {|y| final+=y}
                return final
            when :-
                self.my_each {|y| final-=y}
                return final
            when :*
                self.my_each {|y| final*=y}
                return final
            when :/
                self.my_each {|y| final/=y}
                return final
            end
        end
        if block_given?
            final = 1 if yield(final, self[0]) == 0 || yield(final, self[1]) == 0 if self[1] != nil
            self.my_each {|x| final = yield(final,x)}
            return final
        end
        'nothing'
    end

    def multiply_els(x)
        self.my_inject {|x,y| x*y}
    end

end

some = [1,2,3]

# puts 1.method(:+).call(1)

# some.my_each{|x| puts x}

# puts some.my_each

# some.my_each_with_index{|x| puts x}

# puts some.my_each_with_index

# puts some.my_select{|a| a%2==0}

# puts some.my_all?{|a| a%2==0}

# puts some.my_all?(/\d/)

# puts some.my_all?(String)

# puts some.my_any?{|a| a%2==0}

# puts some.my_any?(/\d/)

# puts some.my_any?(String)

# puts some.my_none?{|a| a%5==0}

# puts some.my_none?(/\W/)

# puts some.my_none?(String)

# puts some.my_count(1)

# puts some.my_count

# puts some.my_count{|a| a%1==0}

# puts some.my_map{|a| a*2}

# puts some.my_map

puts some.my_inject{|x,y| x*y}

puts some.my_inject(1,:+)

puts some.my_inject(1){|x,y| x+y}

puts (Numeric).class