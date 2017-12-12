class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).collect {|i| verse(i)}
  end


  def verse(number)
    case number
    when 0
      "#{quantity(number).capitalize} #{container(number)} of beer on the wall, " +
        "#{quantity(number)} #{container(number)} of beer.\n" +
        "Go to the store and buy some more, " +
        "99 bottles of beer on the wall.\n"
    else
      "#{quantity(number)} #{container(number)} of beer on the wall, " +
        "#{quantity(number)} #{container(number)} of beer.\n" +
        "Take #{pronoun(number)} down and pass it around, " +
        "#{quantity(number-1)} #{container(number-1)} of beer on the wall.\n"
    end
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
end
