require './tic_tac_toe.rb'

puts 'YOU ARE GOING TO HAVE A TIC TAC TOE BATTLE!!!!'

puts 'ENTER THE FIRST CHOSEN ONE NAME:'
name_one = gets.chomp

puts 'ENTER THE SECOND CHOSEN ONE NAME:'
name_two = gets.chomp

game = TicTacToeGame.new(name_one, name_two)
current_player = game.players.sample


loop do

  puts 'Current board status'
  game.board.print

  print "PLACE YOUR '#{current_player.symbol}' #{current_player.name}:"
  turn = gets.chomp until (1..9).include?(turn.to_i)
  game.board.play_on(turn.to_i, current_player)

  if game.won?
    puts "#{current_player.name.upcase} WON THE GAME!!!!!"
    game.board.print
    break
  elsif game.tie?
    puts "YOU ARE EQUALY MACHED, THE GAME IS A TAI!!!!!!!!!!"
    break
  else
    current_player = game.players.reject { |x| x == current_player }.first
  end

end
