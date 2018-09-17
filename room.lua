local class = require("class")
local Player = require("player")

local Room = class()

function Room:ctor()
    self.__players = {}
end

function Room:generate_players()
    for i=1,SEAT_COUNT do
        local player = Player.new(i)
        self.__players[i] = player
    end
end

function Room:get_player(seat_index)
	return self.__players[seat_index]
end

return Room