def duck_duck_goose(players, goose)
  players[(goose - 1) % players.size].name
end
