class Bottles
  attr_accessor :starting_num, :ending_num
  include Enumerable
  def initialize(starting_num=99, ending_num=0)
    @starting_num = starting_num
    @ending_num = ending_num
  end

  def each(&block)
    starting_num.downto(ending_num).map do |n|
      verse = verse_for(n)
      block.call(verse)
      verse
    end
  end

  def to_a
    each {|i| i}
  end

  def verses(starting_num, ending_num=0)
    self.starting_num = starting_num
    self.ending_num = ending_num
    to_a
  end

  private

  def verse_for(n)
    [
      wall_line(n).capitalize + ", " + count_part(n) + ".",
      take_line(n).capitalize + ", " + wall_line(next_verse_number(n)) + ".",
    ].join("\n")
  end

  def wall_line(n)
    "#{count_part(n)} on the wall"
  end

  def take_line(n)
    case
    when n > 1 then
      "Take one down and pass it around"
    when last_bottle?(n) then
      "Take it down and pass it around"
    when n == 0 then
      "Go to the store and buy some more"
    end
  end

  def count_part(n)
    count_word = case n
      when 0 then "no more #{pluralize("bottle", n)}"
      when 6 then '1 six-pack'
      else "#{n} #{pluralize("bottle", n)}"
    end
    "#{count_word} of beer"
  end

  def next_verse_number(n)
    no_bottles?(n) ? n - 1 : starting_num
  end

  def no_bottles?(n)
    n > 0
  end

  def pluralize(word, n)
    last_bottle?(n) ? word : "#{word}s"
  end

  def last_bottle?(n)
    n == 1
  end
end

if $0 == __FILE__
  if ARGV.include?('-n')
    ARGV.delete('-n')
    num_bottles = ARGV[0]
    puts Bottles.new(num_bottles).to_a.join("\n\n")
  else
    puts Bottles.new(99).to_a.join("\n\n")
  end
end