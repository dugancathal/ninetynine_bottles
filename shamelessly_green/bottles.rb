class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).collect {|i| verse(i)}
  end


  def verse(number)
    bottle_number = BottleNumber.new(number)
    next_bottle_number = BottleNumber.new(bottle_number.successor)
    "#{bottle_number.quantity.capitalize} #{bottle_number.container} of beer on the wall, " +
      "#{bottle_number.quantity} #{bottle_number.container} of beer.\n" +
      bottle_number.obtain_bottles +
      "#{next_bottle_number.quantity} #{next_bottle_number.container} of beer on the wall.\n"
  end
end

class BottleNumber < Struct.new(:number)
  def container
    number == 1 ? "bottle" : "bottles"
  end

  def pronoun
    number == 1 ? "it" : "one"
  end

  def quantity
    number == 0 ? "no more" : "#{number}"
  end

  def obtain_bottles
    number == 0 ? "Go to the store and buy some more, " : "Take #{pronoun} down and pass it around, "
  end

  def successor
    number == 0 ? 99 : number - 1
  end
end
