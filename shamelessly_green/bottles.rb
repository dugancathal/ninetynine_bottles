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
  def container(size)
    size != 1 ? "bottles" : "bottle"
  end

  def pronoun(size)
    size != 1 ? "one" : "it"
  end

  def quantity(number)
    number > 0 ? "#{number}" : "no more"
  end

  def obtain_bottles(size)
    size == 0 ? "Go to the store and buy some more, " : "Take #{pronoun(size)} down and pass it around, "
  end

  def successor(number)
    number > 0 ? number - 1 : 99
  end
end
