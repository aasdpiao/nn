local class = require("class")
local nickname = require("nickname")
local random = require("random")
local print_r = require("print_r")
local CardGroup = require("card_group")

local Player = class()

function Player:ctor(seat_index)
    self.__nickname = random.random_one(nickname)
    self.__seat_index = seat_index
    self.__cards = {}
end

function Player:get_seat_index()
    return self.__seat_index
end

function Player:set_cards(cards)
	self.__cards = cards
    print(self.__nickname)
    print_r(cards)
    self.__card_group = CardGroup.new(cards)
    local result_type, max_card, result_cards = self.__card_group:get_card_type()
	print("result_type",result_type)
	print("max_card",max_card)
	self.__card_group:show_cards()
end

return Player