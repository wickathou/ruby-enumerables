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
               if yield(x) == nil || yield(x) == false
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

end

some = [1,2,3]


# some.my_each{|x| puts x}
# puts some.my_each

# some.my_each_with_index{|x| puts x}
# puts some.my_each_with_index

# puts some.my_select{|a| a%2==0}

puts some.my_all?(/\d/)

puts some.my_all?(String)


puts some.class

puts (Numeric).class