require("card_define")
require("luaext")
local class = require("class")
local print_r = require("print_r")
local random = require("random")
local Room = require("room")

local game_state = GAME_STATE.ready_begin

local room = Room.new()
local cards = {}

local function shuffle_cards()
	cards = random.random_shuffle(CARD_POOL)
end

room:generate_players()
shuffle_cards()

for seat_index=1,SEAT_COUNT do
	local card_group = {}
	for i=1,5 do
		local card = table.remove(cards, 1)
		table.insert(card_group, card)
	end
	local player = room:get_player(seat_index)
	player:set_cards(card_group)
end


