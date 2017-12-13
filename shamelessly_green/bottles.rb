class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).collect {|i| verse(i)}
  end


  def verse(number)
    bottle_number = BottleNumber.for(number)
    "#{bottle_number} of beer on the wall, ".capitalize +
      "#{bottle_number} of beer.\n" +
      bottle_number.obtain_bottles +
      "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber < Struct.new(:number)
  def self.for(number)
    case number
    when 0 then BottleNumber0
    when 1 then BottleNumber1
    else BottleNumber
    end.new(number)
  end

  def container
    "bottles"
  end

  def pronoun
    "one"
  end

  def quantity
    "#{number}"
  end

  def obtain_bottles
    "Take #{pronoun} down and pass it around, "
  end

  def successor
    BottleNumber.for(number - 1)
  end

  def to_s
    "#{quantity} #{container}"
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

class BottleNumber0 < BottleNumber
  def quantity
    "no more"
  end

  def obtain_bottles
    "Go to the store and buy some more, "
  end

  def successor
    BottleNumber.for(99)
  end
end
