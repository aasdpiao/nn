local class = require("class")

local Card = class()

function Card:ctor(card)
	self.__card = card
end

function Card:get_card_color()
	return MASK_COLOR & self.__card	
end

function Card:get_card_value()
	return MASK_VALUE & self.__card
end

function Card:get_card_logic_value()
	local card_value = self:get_card_value()
	return (card_value > 10) and 10 or card_value
end

function Card:get_card()
	return self.__card
end

return Card