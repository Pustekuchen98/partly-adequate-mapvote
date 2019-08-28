PAM = {}

--the possible states
--for when it hasn't started yet
PAM.STATE_DISABLED = 0

--for when voting is possible
PAM.STATE_STARTED = 1

--for when the winner is announced
PAM.STATE_FINISHED = 2

--the default configuration
PAM.CONFIG_DEFAULT = {
	
	--length of voting time in seconds
	VoteLength = 30,
	
	--prefixes for searching maps
	MapPrefixes = {"ttt_"},
	
	--the amount of rounds needed for a map to appear again
	MapsBeforeRevote = 3,
	
	--the amount of maps to select from
	MaxMapAmount = 15
}

--the current round
PAM.Round = 0

--the current state
PAM.State = PAM.STATE_DISABLED

--the current configuration
PAM.Config = {}

-- set fallback metatable
setmetatable(PAM.Config, PAM.CONFIG_DEFAULT)

--the voteable maps
PAM.Maps = {}

--the votes
PAM.Votes = {}

--the recently played maps
PAM.RecentMaps = {}

--the play counts of each map
PAM.Playcounts = {}

if not file.Exists("pam", "DATA") then
	file.CreateDir("pam")
end

if not file.Exists("pam/config.txt", "DATA") then
	file.Write("pam/config.txt", util.TableToJSON(PAM.CONFIG_DEFAULT))
end

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("pam/cl_pam.lua")

	include("pam/sv_pam.lua")
else
	include("pam/cl_pam.lua")
end