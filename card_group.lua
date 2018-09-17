local class = require("class")
local Card = require("card")

local CardGroup = class()

function CardGroup:ctor(cards)
	self.__cards = {}
	for i,v in ipairs(cards) do
		self.__cards[i] = Card.new(v)
	end
end

function CardGroup:get_cards()
	local cards = {}
	for i,v in ipairs(self.__cards) do
		cards[i] = v:get_card()
	end
	return cards
end

function CardGroup:get_card_type()
	assert(#self.__cards == 5)
	local sum_logic_value = 0 --总计数
	local pai_king_count = 0 --JQK的张数
	local pai_10_count = 0 --牌10的张数
	local max_card = 0x00 --最大的那张牌

	table.sort(self.__cards, function(a, b)
		local valuea = a:get_card_value()
		local valueb = b:get_card_value()
		if valuea < valueb then
			return true
		end
		if valuea == valueb then
			if a:get_card_color() < b:get_card_color() then
				return true
			end
			return false
		end
	end)

	max_card = self.__cards[5]:get_card()

	for _, v in ipairs(self.__cards) do
		local card_value = v:get_card_value()
		local logic_value = v:get_card_logic_value()
		if card_value > 10 then
			pai_king_count = pai_king_count + 1
		elseif card_value == 10 then
			pai_10_count = pai_10_count + 1
		end
		sum_logic_value = sum_logic_value + logic_value
	end

	if pai_king_count == 5 then
		return CARD_TYPE.king5_niu, max_card, self:get_cards()
	end

	if pai_king_count == 4 and pai_10_count == 1 then
		return CARD_TYPE.king4_niu, max_card, self:get_cards()
	end

	
	local result_group = nil
	local result_cards = {}
	local result_type = CARD_TYPE.no_niu
	for _, group in ipairs(GROUP_TYPE) do
		local tmp_sum_value = 0
		for i, v in ipairs(group) do
			if i < 4 then
				tmp_sum_value = tmp_sum_value + self.__cards[v]:get_card_logic_value()
			end
		end
		if tmp_sum_value % 10 == 0 then
			local left_value = sum_logic_value - tmp_sum_value
			left_value = (left_value > 10) and (left_value - 10) or left_value
			if left_value > result_type then
				result_type = left_value
				result_group = group
			end 
		end
	end

	if result_type ~= CARD_TYPE.no_niu then
		for k, v in ipairs(result_group) do
			result_cards[k] = self.__cards[v]:get_card()
		end
	end
	return result_type, max_card, result_cards
end

return CardGroup