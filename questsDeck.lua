function onLoad()
  if not Global.get('gameMode').ageOfGiants then
    self.setPosition({self.getPosition().x, 0.5, self.getPosition().z})
  end
end
