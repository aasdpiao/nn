local class = require("class")

local Card = class()

local card_colors = {"方块","梅花","红桃","黑桃"}
local card_values = {"A","2","3","4","5","6","7","8","9","10","J","Q","K"}

function Card:ctor(card)
	self.__card = card
end

function Card:get_card_color()
	return (MASK_COLOR & self.__card) >> 4
end

function Card:get_card_value()
	return MASK_VALUE & self.__card
end

function Card:get_card_logic_value()
	local card_value = self:get_card_value()
	return (card_value > 10) and 10 or card_value
end

function Card:get_card_str()
	local card_color = self:get_card_color()
	local card_value = self:get_card_value()
	return card_colors[card_color]..card_values[card_value]
end

function Card:get_card()
	return self.__card
end

return Card