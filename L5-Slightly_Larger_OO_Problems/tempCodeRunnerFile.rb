    loop do
      case player_hit_or_stay
      when HIT
        hit(player.hand)
        puts "You hit!"
        break "You busted!" if player.busted?
      when STAY
        break puts "You stayed!"
      end
    end