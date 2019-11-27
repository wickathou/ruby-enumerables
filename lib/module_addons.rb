# frozen_string_literal: true

module Enumerable
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
end
