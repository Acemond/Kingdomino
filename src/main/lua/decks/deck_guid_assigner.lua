local deck_guid = ""

function onLoad()
  deck = getObjectFromGUID(deck_guid)
  for i = 46, 1, -1 do
    deck.takeObject({
      position = { deck.getPosition().x, deck.getPosition().y + i + 0.1 * (i - 1), deck.getPosition().z },
      smooth = false
    })
  end
end