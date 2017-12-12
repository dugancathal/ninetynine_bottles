class Bottles < Struct.new(:num_bottles)
  include Enumerable

  def each(&block)
    num_bottles.downto(0).map do |n|
      verse = verse_for(n)
      block.call(verse)
      verse
    end
  end

  def to_a
    each {|i| i}
  end

  private

  def verse_for(n)
    [
      wall_line(n) + ",",
      count_part(n),
      take_line(n) + ",",
      wall_line(next_verse_number(n)),
    ].join("\n")
  end

  def wall_line(n)
    "#{count_part(n)} on the wall"
  end

  def take_line(n)
    case
    when n > 1 then
      "Take one down, pass it around"
    when last_bottle?(n) then
      "Take it down, pass it around"
    when n == 0 then
      "Go to the store and buy some more"
    end
  end

  def count_part(n)
    count_word = n == 0 ? 'No more' : n
    "#{count_word} #{pluralize("bottle", n)} of beer"
  end

  def next_verse_number(n)
    no_bottles?(n) ? n - 1 : num_bottles
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
    puts Bottles.new(num_bottles).to_a
  else
    puts Bottles.new(99).to_a
  end
end