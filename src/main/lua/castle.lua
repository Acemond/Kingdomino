color = "Red"
textColor = {r=1, g=0, b=0}

function setReady()
  broadcastToAll("Red player is ready for the next turn", {r=0, g=0.75, b=0})
end

function unsetReady()
  broadcastToAll("Red player is reconsidering...", {r=0.8, g=0.8, b=0.8})
end

