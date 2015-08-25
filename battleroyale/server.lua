local START_GAME_PLAYER_COUNT = 32
local GREEN_CIRCLE_POS = {0, 0}
local GREEN_CIRCLE_RADIUS = 300
local CURRENT_GAME_STATE = 1
local GLOBAL_COL_SHAPE = nil

function onPlayerJoinHandler()
	if getPlayerCount() >= START_GAME_PLAYER_COUNT then
		triggerEvent("onGameStarting", getRootElement())
	end
end

function onGameStartingHandler()
	for player in pairs(getElementsByType("player")) do
		setElementPosition(player, 0, 0, 500)
		giveWeapon(player, 46, 1, true)
	end

	prepareColShape()
	prepareGameTimers()
end

function prepareColShape()
	GLOBAL_COL_SHAPE = createColCircle(GREEN_CIRCLE_POS[1], GREEN_CIRCLE_POS[2], GREEN_CIRCLE_RADIUS)
end

function prepareGameTimers()
	setTimer(mainGamemodeLoop, 10000, 3)
end

function mainGamemodeLoop()
	CURRENT_GAME_STATE++
	GREEN_CIRCLE_RADIUS = GREEN_CIRCLE_RADIUS / 2
end

function onPlayerDiedHandler()
	kickPlayer(source, "Good luck next time!")
end

addEvent("onGameStarting", false)

addEventHandler("onPlayerJoin", getRootElement(), onPlayerJoinHandler)
addEventHandler("onGameStarting", getRootElement(), onGameStartingHandler)
addEventHandler("onPlayerWasted", getRootElement(), onPlayerDiedHandler)