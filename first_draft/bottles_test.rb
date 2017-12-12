require 'rspec'
require 'rspec/autorun'
require_relative './bottles'

RSpec::Matchers.define(:eq_wo_whitespace) do |expected|
  match do |actual|
    actual.gsub(/\s/, '') == expected.gsub(/\s/, '')
  end

  failure_message do |actual|
    <<-MSG
      expected: #{expected.strip}
      got:      #{actual.strip}
    MSG
  end
end

RSpec.describe 'Bottles' do
  it 'returns a single line correctly' do
    expect(Bottles.new(5).first).to eq_wo_whitespace <<~BOTTLES
      5 bottles of beer on the wall,
      5 bottles of beer
      Take one down, pass it around,
      4 bottles of beer on the wall
    BOTTLES
  end

  it 'returns multiple sequential lines correctly' do
    five_bottles, four_bottles = Bottles.new(5).first(2)
    expect(five_bottles).to eq_wo_whitespace <<~BOTTLES
      5 bottles of beer on the wall,
      5 bottles of beer
      Take one down, pass it around,
      4 bottles of beer on the wall
    BOTTLES
    expect(four_bottles).to eq_wo_whitespace <<~BOTTLES
      4 bottles of beer on the wall,
      4 bottles of beer
      Take one down, pass it around,
      3 bottles of beer on the wall
    BOTTLES
  end

  it 'returns the 2 bottles verse' do
    expect(Bottles.new(2).first).to eq_wo_whitespace <<~BOTTLES
      2 bottles of beer on the wall,
      2 bottles of beer
      Take one down, pass it around,
      1 bottle of beer on the wall
    BOTTLES
  end

  it 'returns the penultimate (1 bottle) verse' do
    expect(Bottles.new(1).first).to eq_wo_whitespace <<~BOTTLES
      1 bottle of beer on the wall,
      1 bottle of beer
      Take it down, pass it around,
      No more bottles of beer on the wall
    BOTTLES
  end

  it 'returns the final verse (and starts over)' do
    expect(Bottles.new(99).to_a.last).to eq_wo_whitespace <<~BOTTLES
      No more bottles of beer on the wall,
      No more bottles of beer
      Go to the store and buy some more,
      99 bottles of beer on the wall
    BOTTLES
  end
end