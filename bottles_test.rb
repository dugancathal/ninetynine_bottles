require 'rspec'
require 'rspec/autorun'

RSpec::Matchers.define(:eq_wo_whitespace) do |expected|
  match do |actual|
    actual.strip == expected.strip
  end

  failure_message do |actual|
    <<~MSG
      expected: #{expected.strip.inspect}
      got:      #{actual.strip.inspect}
    MSG
  end
end

versions = ['first_draft', 'shamelessly_green'].map do |mod|
  Module.new do
    define_singleton_method(:to_s) {mod}
    define_singleton_method(:inspect) {mod}

    mod_path = File.expand_path("./#{mod}", __dir__)
    Dir.chdir(mod_path) do
      module_eval File.read(File.join(mod_path, "bottles.rb"))
    end
  end
end

versions.each do |version|
  RSpec.describe "#{version.to_s}::Bottles" do
    it 'returns a single line correctly' do
      expect(version::Bottles.new.verses(5, 0).first).to eq_wo_whitespace <<~BOTTLES
        5 bottles of beer on the wall, 5 bottles of beer.
        Take one down and pass it around, 4 bottles of beer on the wall.
      BOTTLES
    end

    it 'returns multiple sequential lines correctly' do
      five_bottles, four_bottles = version::Bottles.new.verses(5, 0).first(2)
      expect(five_bottles).to eq_wo_whitespace <<~BOTTLES
        5 bottles of beer on the wall, 5 bottles of beer.
        Take one down and pass it around, 4 bottles of beer on the wall.
      BOTTLES
      expect(four_bottles).to eq_wo_whitespace <<~BOTTLES
        4 bottles of beer on the wall, 4 bottles of beer.
        Take one down and pass it around, 3 bottles of beer on the wall.
      BOTTLES
    end

    it 'returns the 2 bottles verse' do
      expect(version::Bottles.new.verses(2, 0).first).to eq_wo_whitespace <<~BOTTLES
        2 bottles of beer on the wall, 2 bottles of beer.
        Take one down and pass it around, 1 bottle of beer on the wall.
      BOTTLES
    end

    it 'returns the penultimate (1 bottle) verse' do
      expect(version::Bottles.new.verses(1, 0).first).to eq_wo_whitespace <<~BOTTLES
        1 bottle of beer on the wall, 1 bottle of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
      BOTTLES
    end

    it 'returns the final verse (and starts over)' do
      expect(version::Bottles.new.verses(99, 0).to_a.last).to eq_wo_whitespace <<~BOTTLES
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
      BOTTLES
    end

    it 'returns "1 six-pack" instead of 6 bottles' do
      expect(version::Bottles.new.verses(7, 6).first).to eq_wo_whitespace <<~BOTTLES
        7 bottles of beer on the wall, 7 bottles of beer.
        Take one down and pass it around, 1 six-pack of beer on the wall.
      BOTTLES
      expect(version::Bottles.new.verses(7, 6).last).to eq_wo_whitespace <<~BOTTLES
        1 six-pack of beer on the wall, 1 six-pack of beer.
        Take one down and pass it around, 5 bottles of beer on the wall.
      BOTTLES
    end
  end
end