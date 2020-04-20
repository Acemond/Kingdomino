--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]

--[[ The Update function. This is called once per frame. --]]
function update()
    --[[ print('Update loop!') --]]
end

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onLoad()
  local queendominoDeck = getObjectFromGUID("fadfa0")
  local kingdominoDeck = getObjectFromGUID("0672d4")
  local deck = queendominoDeck

  Global.setVar('deck', deck)
  Global.setVar('tileValues', assignTilesValue(deck))
end

function assignTilesValue(deck)
  local values = {}
  local tiles = deck.getObjects()
  for i = 1, #tiles, 1 do
  	values[tiles[i].guid] = i
  end
  return values
end
