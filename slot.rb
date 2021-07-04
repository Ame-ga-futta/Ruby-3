#------------------------メソッド------------------------

def game_start(game_start_credit, game_start_point)
  puts "--------------------------------------------------"
  puts "残りコイン #{game_start_credit}"
  puts "獲得ポイント #{game_start_point}"
  puts "何コイン入れますか？"
  puts "1.(10コイン:倍率1) 2.(30コイン:倍率1.5) 3.(50コイン:倍率2) 4.(やめる)"
  puts "--------------------------------------------------"
  
  game_start_bet = gets.chomp.to_i
  
  case game_start_bet #入力を変換
    when 1
      game_start_bet = 10
      game_start_coefficient = 1
    when 2
      game_start_bet = 30
      game_start_coefficient = 1.5
    when 3
      game_start_bet = 50
      game_start_coefficient = 2
    when 4 #入力がやめるの場合
      puts "ゲームを終了します"
      game_start_bet = "end"
      return game_start_bet, game_start_coefficient, game_start_credit
    else #入力が不正の場合
      puts "どれかにしてください！"
      game_start_bet = "restart"
      return game_start_bet, game_start_coefficient, game_start_credit
  end
  
  if game_start_credit < game_start_bet #残りコインが投入数より少ない場合
    puts "コインが足りません"
    game_start_bet = "restart"
    game_start_coefficient = 1
    return game_start_bet, game_start_coefficient, game_start_credit
  end
  
  game_start_credit -= game_start_bet
  
  return game_start_bet, game_start_coefficient, game_start_credit
end

def slot
  patterns = ["7", "5", "3", "1" ]
  column_1 = [patterns.sample, patterns.sample, patterns.sample]
  column_2 = [patterns.sample, patterns.sample, patterns.sample]
  column_3 = [patterns.sample, patterns.sample, patterns.sample]
  input = 0
  count = 3
  perfect_count_slot = 0
  
  puts "エンターを3回押しましょう！"
  
  count.times do
    gets
    case input
      when 0
        puts "--------------------------------------------------"
        puts "|#{column_1[0]}| |/|"
        puts "|#{column_1[1]}| |/|"
        puts "|#{column_1[2]}| |/|"
      when 1
        puts "--------------------------------------------------"
        puts "|#{column_1[0]}| |#{column_2[0]}| |/|"
        puts "|#{column_1[1]}| |#{column_2[1]}| |/|"
        puts "|#{column_1[2]}| |#{column_2[2]}| |/|"
      when 2
        puts "--------------------------------------------------"
        puts "|#{column_1[0]}| |#{column_2[0]}| |#{column_3[0]}|"
        puts "|#{column_1[1]}| |#{column_2[1]}| |#{column_3[1]}|"
        puts "|#{column_1[2]}| |#{column_2[2]}| |#{column_3[2]}|"
        puts "--------------------------------------------------"
    end  
    input += 1
  end

  if column_1[0] == column_2[0] && column_1[0] == column_3[0]
    puts "上段に#{column_1[0]}が揃いました！"
    perfect_count_slot += 1
  end
  if column_1[1] == column_2[1] && column_1[1] == column_3[1]
    puts "中段に#{column_1[1]}が揃いました！"
    perfect_count_slot += 1
  end
  if column_1[2] == column_2[2] && column_1[2] == column_3[2]
    puts "下段に#{column_1[2]}が揃いました！"
    perfect_count_slot += 1
  end
  if column_1[0] == column_2[1] && column_1[0] == column_3[2]
    puts "斜めに#{column_1[0]}が揃いました！"
    perfect_count_slot += 1
  end
  if column_1[2] == column_2[1] && column_1[2] == column_3[0]
    puts "斜めに#{column_1[2]}が揃いました！"
    perfect_count_slot += 1
  end
  
  if perfect_count_slot > 0
    puts "#{perfect_count_slot}列揃いました！"
  else
    puts "揃いませんでした"
  end
  
  return perfect_count_slot
end

def result(point)
  puts "----------------------結果-------------------------"
  puts "獲得ポイントは#{point}ポイントです！"
  puts "--------------------------------------------------"
end

#------------------------本文------------------------

credit = 100
point = 0

while (credit != 0)
  bet, coefficient, credit = game_start(credit, point)
  if (bet == "end")
    break
  elsif(bet == "restart")
    next
  else
    perfect_count = slot
    point += (bet * coefficient * perfect_count)
  end
end

if credit == 0
  puts "コインが無くなりました"
end

result(point)

#------------------------テスト用------------------------
#puts "--------------------------------------------------"
#puts "残りコイン #{credit}"
#puts "ベットした枚数 #{bet}"
#puts "係数 #{coefficient}"
#puts "成功回数#{perfect_count}"
#puts "獲得ポイント #{point}"
#puts "--------------------------------------------------"