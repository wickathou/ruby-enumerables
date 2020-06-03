require_relative '../lib/module_addons'
require_relative '../module'

describe Enumerable do
  let(:arr) {[1,2,3,4,5]}
  let(:hash) {{:t1=>1,:t2=>2,:t3=>3,:t4=>4,:t5=>5}}

  describe '#my_each' do
    describe 'Array with block' do
      it 'loops through each element in an array' do
        i = 0
        arr.my_each{|x|
          expect(x).to eq(arr[i])
          i += 1
        }
      end
    end
    describe 'Hash with block' do
      it 'loops through each element in an array' do
        i = 0
        hash.my_each{|x|
          expect(x).to eq(hash[hash.keys[i]])
          i += 1
        }
      end
    end
    describe 'Without block' do
      it 'loops through each element in an array' do
        acc = arr.my_each
        expect(acc).to be_an_instance_of(Enumerator)
      end
    end
  end
  
  describe '#my_each_with_index' do
    describe 'Array with block' do
      it 'loops through each element in an array' do
        acc = []
        arr.my_each_with_index{|x,i|
          acc << x
          expect(acc[i]).to eq(arr[i])
        }
      end
    end
    describe 'Hash with block' do
      it 'loops through each element in an array' do
        acc = []
        hash.my_each_with_index{|x,i|
          acc << x
          expect(acc[i]).to eq(hash.to_a[i])
        }
      end
    end
    describe 'Without block' do
      it 'loops through each element in an array' do
        acc = arr.my_each_with_index
        expect(acc).to be_an_instance_of(Enumerator)
      end
    end
  end
  
  describe '#my_select' do
    describe 'my_select with block' do
      it 'Creates a new array using a filtering condition given on a block' do
        acc = arr.my_select { |a| a.even? }
        expect(acc).to eq([2,4])
      end
    end
    
    describe 'my_select without block' do
      it 'Creates a new array using a filtering condition given on a block' do
        acc = arr.my_select
        expect(acc).to be_an_instance_of(Enumerator)
      end
    end
  end
  
  describe '#my_all?' do
    describe 'my_all? with block' do
      it 'Return false if not all elements meet the block criteria' do
        acc = arr.my_all? { |a| a.even? }
        expect(acc).to eq(false)
      end
      
      it 'Return true if all elements meet the block criteria' do
        acc = arr.my_all? { |a| a.is_a?(Numeric) }
        expect(acc).to eq(true)
      end
    end
    
    describe 'my_all? with pattern' do
      it 'Return true if all elements are the same class as the pattern' do
        acc = arr.my_all?(Numeric)
        expect(acc).to eq(true)
      end
      
      it 'Return false if not all elements are the same value as the pattern' do
        acc = arr.my_all?(1)
        expect(acc).to eq(false)
      end
      
      it 'Return true if all elements fit the regex the pattern' do
        acc = arr.my_all?(/\d/)
        expect(acc).to eq(true)
      end
      
      it 'Return true if all elements are not false or nil' do
        acc = arr.my_all?
        expect(acc).to eq(true)
      end
    end
  end
  
  describe '#my_any?' do
    
    describe 'my_any? with block' do
      it 'Return true if any of the elements meet the block criteria' do
        acc = arr.my_any? { |a| a.even? }
        expect(acc).to eq(true)
      end
    end
    
    describe 'my_any? with pattern' do
      it 'Return true if any of the elements are the same class as the pattern' do
        acc = arr.my_any?(Numeric)
        expect(acc).to eq(true)
      end
      
      it 'Return false if not any of the elements are the same value as the pattern' do
        acc = arr.my_any?('a')
        expect(acc).to eq(false)
      end
      
      it 'Return true if any of the elements fit the regex the pattern' do
        acc = arr.my_any?(/[1-2]/)
        expect(acc).to eq(true)
      end
      
      it 'Return false if none of the elements fit the regex the pattern' do
        acc = arr.my_any?(/\D/)
        expect(acc).to eq(false)
      end
      
      it 'Return true if any of the elements are true' do
        acc = arr.my_any?
        expect(acc).to eq(true)
      end
    end
  end
  
  describe '#my_none?' do
    
    describe 'my_none? with block' do
      it 'Return true if not all of the elements meet the block criteria' do
        acc = arr.my_none? { |a| a == 10 }
        expect(acc).to eq(true)
      end
    end
    
    describe 'my_none? with pattern' do
      it 'Return false if all elements are the same class as the pattern' do
        acc = arr.my_none?(Numeric)
        expect(acc).to eq(false)
      end
      
      it 'Return true if none of the elements are the same class as the pattern' do
        acc = arr.my_none?(String)
        expect(acc).to eq(true)
      end
      
      it 'Return true if not all elements are the same as the pattern' do
        acc = arr.my_none?('a')
        expect(acc).to eq(true)
      end
      
      it 'Return false if not all elements are the same value as the pattern' do
        acc = arr.my_none?(1)
        expect(acc).to eq(false)
      end
      
      it 'Return false if some elements do not fit the regex the pattern' do
        acc = arr.my_none?(/[1-2]/)
        expect(acc).to eq(false)
      end
      
      it 'Return true if all elements do not fit the regex the pattern' do
        acc = arr.my_none?(/\D/)
        expect(acc).to eq(true)
      end
      
      it 'Return false if all elements are true' do
        acc = arr.my_none?
        expect(acc).to eq(false)
      end
    end
  end
  
  describe '#my_count' do
    
    describe 'my_count with block' do
      it 'Return the number of items that yield true' do
        acc = arr.my_count { |a| a.even? }
        expect(acc).to eq(2)
      end
    end
    
    describe 'my_count with a paratemer' do
      it 'Return the number of items that are equal to the paratemer' do
        acc = arr.my_count(1)
        expect(acc).to eq(1)
      end
    end
    
    describe 'my_count without paratemer or block' do
      it 'Return the number of items' do
        acc = arr.my_count
        expect(acc).to eq(5)
      end
    end
  end
  
  describe '#my_map' do
    describe 'my_map with block' do
      it 'Yields the block value to all elements in the array' do
        acc = arr.my_map { |a| a * a }
        expect(acc).to eq([1,4,9,16,25])
      end
    end
    
    describe 'my_map without block' do
      it 'Returns an Enumerator' do
        acc = arr.my_map
        expect(acc).to be_an_instance_of(Enumerator)
      end
    end
  end
  
  describe '#my_inject' do
    describe 'my_inject with block' do
      it 'Yields the block operation with + to combine all elements' do
        acc = arr.my_inject { |a , b| a + b}
        expect(acc).to eq(15)
      end
    end
    
    describe 'my_inject with symbol' do
      it 'Yields the symbol operator with send + to combine all elements' do
        acc = arr.my_inject(:+)
        expect(acc).to eq(15)
      end
    end
    
    describe 'my_inject with block and initial value' do
      it 'Yields the block operation with + to combine all elements with the initial value' do
        acc = arr.my_inject(1) { |a , b| a + b}
        expect(acc).to eq(16)
      end
    end
    
    describe 'my_inject with symbol and initial value' do
      it 'Yields the symbol operator with send + to combine all elements and the initial value' do
        acc = arr.my_inject(1,:+)
        expect(acc).to eq(16)
      end
    end
    
    describe 'my_inject with block' do
      it 'Yields the block operation with * to combine all elements' do
        acc = arr.my_inject { |a , b| a * b}
        expect(acc).to eq(120)
      end
    end
    
    describe 'my_inject with symbol' do
      it 'Yields the symbol operator with send * to combine all elements' do
        acc = arr.my_inject(:*)
        expect(acc).to eq(120)
      end
    end
    
    describe 'my_inject with block and initial value' do
      it 'Yields the block operation with * to combine all elements with the initial value' do
        acc = arr.my_inject(2) { |a , b| a * b}
        expect(acc).to eq(240)
      end
    end
    
    describe 'my_inject with symbol and initial value' do
      it 'Yields the symbol operator with send * to combine all elements and the initial value' do
        acc = arr.my_inject(2,:*)
        expect(acc).to eq(240)
      end
    end
  end
  
  describe '#multiply_els' do
    describe 'Method that uses my_inject' do
      it 'A method using inject with a multiplying operator' do
        expect(multiply_els(arr)).to eq(120)
      end
    end
  end


end
