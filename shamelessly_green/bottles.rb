class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).collect {|i| verse(i)}
  end


  def verse(number)
    "#{quantity(number).capitalize} #{container(number)} of beer on the wall, " +
      "#{quantity(number)} #{container(number)} of beer.\n" +
      obtain_bottles(number) +
      "#{quantity(successor(number))} #{container(successor(number))} of beer on the wall.\n"
  end

  private
  def container(number)
    number == 1 ? "bottle" : "bottles"
  end

  def pronoun(number)
    number == 1 ? "it" : "one"
  end

  def quantity(number)
    number == 0 ? "no more" : "#{number}"
  end

  def obtain_bottles(number)
    number == 0 ? "Go to the store and buy some more, " : "Take #{pronoun(number)} down and pass it around, "
  end

  def successor(number)
    number == 0 ? 99 : number - 1
  end
end
