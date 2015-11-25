class Luhn
  attr_reader :number, :digits, :checksum
  attr_accessor :addends

  def initialize(number)
    @number = number
    @digits = number.to_s.chars.map(&:to_i)
    @addends = double_every_other_digit_from_right_to_left
    @checksum = @addends.reduce(:+)
  end  

  def valid?
    checksum % 10 == 0
  end 

  def self.create(number)
    valid_number = new(number * 10)
    check_digit = (valid_number.checksum * 9) % 10
    valid_number.digits[-1] = check_digit
    valid_number.digits.join.to_i
  end 

  private

  def double_every_other_digit_from_right_to_left
    doubled_digits = []
    digits.reverse.each_with_index do |digit, index|
      new_digit = 0
      if index.even?
        new_digit = digit
      else
        digit * 2 > 10 ? new_digit = (digit * 2) - 9 : new_digit = digit * 2
      end
      doubled_digits << new_digit  
    end 
    doubled_digits.reverse 
  end 

end