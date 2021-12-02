require './lib/turn'
require './lib/card'
require './lib/deck'
require './lib/round'

card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
cards = [card_1, card_2, card_3]
deck = Deck.new(cards)
round = Round.new(deck)

def start(round)
  puts "Welcome! You're playing with #{round.deck.cards.length} cards."
  puts "-" * 50
  while round.turns.length < round.deck.cards.length
    puts "This is card number #{round.turns.length + 1} out of #{round.deck.cards.length}."
    puts "Question: #{round.current_card.question}"
    guess = gets.chomp
    round.take_turn(guess)
    p round.turns.last.feedback
  end
  gameover(round)
end

def gameover(round)
  puts "****** Game over! ******"
  puts "You had #{round.number_correct} correct guesses out of #{round.deck.cards.length} for a total score of #{round.percent_correct.to_i}%"
  categories = []
  round.turns.each do |turn|
    categories << turn.card.category unless categories.include?(turn.card.category)
  end
  categories.each do |category|
    puts "#{category} - #{round.percent_correct_by_category(category).to_i}% correct"
  end
end

start(round)
