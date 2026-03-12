RGT = {}

RGT.guildMap = {}
RGT.queue = {}

RGT.lastRankIndex = nil
RGT.targetRank = nil
RGT.targetRankIndex = nil
RGT.mode = "PROMOTE"

-------------------------------------------------
-- FRAME
-------------------------------------------------

local frame = CreateFrame("Frame","RGT_Frame",UIParent,"BackdropTemplate")
frame:SetSize(780,650)
frame:SetPoint("CENTER")

frame:SetBackdrop({
bgFile="Interface/Tooltips/UI-Tooltip-Background",
edgeFile="Interface/Tooltips/UI-Tooltip-Border",
edgeSize=12
})

frame:SetBackdropColor(0,0,0,0.9)

frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")

frame:SetScript("OnDragStart",frame.StartMoving)
frame:SetScript("OnDragStop",frame.StopMovingOrSizing)

frame:Hide()
tinsert(UISpecialFrames,"RGT_Frame")

-------------------------------------------------
-- HEADER
-------------------------------------------------

local title = frame:CreateFontString(nil,"OVERLAY","GameFontNormalLarge")
title:SetPoint("TOP",0,-10)
title:SetText("Rütlischwur Gilden Tool")

local close = CreateFrame("Button",nil,frame,"UIPanelCloseButton")
close:SetPoint("TOPRIGHT")

-------------------------------------------------
-- MODE TEXT
-------------------------------------------------

local modeText = frame:CreateFontString(nil,"OVERLAY","GameFontHighlight")
modeText:SetPoint("TOP",0,-40)
modeText:SetText("Mode: Promote")

-------------------------------------------------
-- NEXT PLAYER
-------------------------------------------------

local nextPlayerText = frame:CreateFontString(nil,"OVERLAY","GameFontHighlight")
nextPlayerText:SetPoint("TOP",0,-60)
nextPlayerText:SetText("Next Player: None")

-------------------------------------------------
-- IMPORT RESULT
-------------------------------------------------

local resultText = frame:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
resultText:SetPoint("TOP",0,-80)

-------------------------------------------------
-- MODE BUTTONS
-------------------------------------------------

local promoteBtn = CreateFrame("Button",nil,frame,"UIPanelButtonTemplate")
promoteBtn:SetSize(120,24)
promoteBtn:SetPoint("TOP",-70,-110)
promoteBtn:SetText("Promote Mode")

local demoteBtn = CreateFrame("Button",nil,frame,"UIPanelButtonTemplate")
demoteBtn:SetSize(120,24)
demoteBtn:SetPoint("LEFT",promoteBtn,"RIGHT",20,0)
demoteBtn:SetText("Demote Mode")

promoteBtn:SetScript("OnClick",function()
RGT.mode="PROMOTE"
modeText:SetText("Mode: Promote")
end)

demoteBtn:SetScript("OnClick",function()
RGT.mode="DEMOTE"
modeText:SetText("Mode: Demote")
end)

-------------------------------------------------
-- RANK DROPDOWN
-------------------------------------------------

local rankDropdown = CreateFrame("Frame","RGT_RankDropdown",frame,"UIDropDownMenuTemplate")
rankDropdown:SetPoint("TOP",0,-150)

UIDropDownMenu_SetWidth(rankDropdown,220)
UIDropDownMenu_SetText(rankDropdown,"Select Target Rank")

UIDropDownMenu_Initialize(rankDropdown,function()

local myRank = select(3,GetGuildInfo("player"))
local numRanks = GuildControlGetNumRanks()

for i=1,numRanks do

local rankName = GuildControlGetRankName(i)
local rankIndex = i-1

if rankIndex > myRank then

local info = UIDropDownMenu_CreateInfo()

info.text = rankName

info.func = function()

UIDropDownMenu_SetText(rankDropdown,rankName)

RGT.targetRank = rankName
RGT.targetRankIndex = rankIndex

end

UIDropDownMenu_AddButton(info)

end

end

end)

-------------------------------------------------
-- IMPORT BOX
-------------------------------------------------

local importBG = CreateFrame("Frame",nil,frame,"BackdropTemplate")
importBG:SetSize(720,120)
importBG:SetPoint("TOP",0,-190)

importBG:SetBackdrop({
bgFile="Interface/Tooltips/UI-Tooltip-Background",
edgeFile="Interface/Tooltips/UI-Tooltip-Border",
edgeSize=12
})

importBG:SetBackdropColor(0.1,0.1,0.1,0.9)

local scroll = CreateFrame("ScrollFrame",nil,importBG,"UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT",10,-10)
scroll:SetPoint("BOTTOMRIGHT",-30,10)

local editBox = CreateFrame("EditBox",nil,scroll)
editBox:SetMultiLine(true)
editBox:SetFontObject(ChatFontNormal)
editBox:SetWidth(680)
editBox:SetAutoFocus(false)

scroll:SetScrollChild(editBox)

-------------------------------------------------
-- IMPORT BUTTON
-------------------------------------------------

local importBtn = CreateFrame("Button",nil,frame,"UIPanelButtonTemplate")
importBtn:SetSize(150,30)
importBtn:SetPoint("TOP",0,-340)
importBtn:SetText("Import Players")

-------------------------------------------------
-- QUEUE
-------------------------------------------------

local queueBG = CreateFrame("Frame",nil,frame,"BackdropTemplate")

queueBG:SetSize(720,260)
queueBG:SetPoint("BOTTOM",0,20)

queueBG:SetBackdrop({
bgFile="Interface/Tooltips/UI-Tooltip-Background",
edgeFile="Interface/Tooltips/UI-Tooltip-Border",
edgeSize=12
})

queueBG:SetBackdropColor(0.05,0.05,0.05,0.9)

local queueText = queueBG:CreateFontString(nil,"OVERLAY","GameFontHighlightSmall")
queueText:SetPoint("TOPLEFT",10,-10)
queueText:SetJustifyH("LEFT")

-------------------------------------------------
-- BUILD GUILD MAP
-------------------------------------------------

function RGT_BuildGuildMap()

wipe(RGT.guildMap)

local total = GetNumGuildMembers()

for i=1,total do

local name, rank, rankIndex = GetGuildRosterInfo(i)

if name then

local short = Ambiguate(name,"short")

RGT.guildMap[strlower(short)] = {
full = name,
rank = rank,
rankIndex = rankIndex
}

end

end

end

-------------------------------------------------
-- BUILD QUEUE
-------------------------------------------------

function RGT_BuildQueue()

wipe(RGT.queue)

local _,_,myRankIndex = GetGuildInfo("player")

for name in string.gmatch(editBox:GetText(),"[^\r\n]+") do

name = strtrim(name)

-- akzeptiert Player und Player-Realm
local short = name:match("([^%-]+)")
local key = strlower(short)

local player = RGT.guildMap[key]

if player then

if player.rankIndex > myRankIndex then

if RGT.mode=="PROMOTE" and player.rankIndex > RGT.targetRankIndex then

table.insert(RGT.queue,{
name=player.full,
current=player.rank,
target=RGT.targetRank
})

elseif RGT.mode=="DEMOTE" and player.rankIndex < RGT.targetRankIndex then

table.insert(RGT.queue,{
name=player.full,
current=player.rank,
target=RGT.targetRank
})

end

end

end

end

RGT_UpdateUI()
RGT_UpdateMacro()

if RGT.queue[1] then
local p = RGT.guildMap[strlower(Ambiguate(RGT.queue[1].name,"short"))]
if p then
RGT.lastRankIndex = p.rankIndex
end
end

end

-------------------------------------------------
-- UPDATE UI (FORMATTED TABLE)
-------------------------------------------------

function RGT_UpdateUI()

local header = string.format("%-22s | %-18s | %-18s\n","Name","Current Rank","Target Rank")
local divider = "----------------------------------------------------------------\n"

local text = header..divider

for i,data in ipairs(RGT.queue) do

text = text .. string.format(
"%-22s | %-18s | %-18s\n",
data.name,
data.current,
data.target
)

end

queueText:SetText(text)

if RGT.queue[1] then

nextPlayerText:SetText(
"Next Player: "..RGT.queue[1].name..
" ("..RGT.queue[1].current.." -> "..RGT.queue[1].target..")"
)

else

nextPlayerText:SetText("Next Player: None")

end

end

-------------------------------------------------
-- MACRO SYSTEM
-------------------------------------------------

function RGT_UpdateMacro()

local player = RGT.queue[1]

local promoteName = "RGT_PROMOTE"
local demoteName = "RGT_DEMOTE"

local promoteIcon = "Ability_Warrior_BattleShout"
local demoteIcon = "Ability_Creature_Cursed_02"

local promoteIndex = GetMacroIndexByName(promoteName)
local demoteIndex = GetMacroIndexByName(demoteName)

if not player then

local empty="#showtooltip\n"

if promoteIndex==0 then
CreateMacro(promoteName,promoteIcon,empty,false)
else
EditMacro(promoteIndex,promoteName,promoteIcon,empty)
end

if demoteIndex==0 then
CreateMacro(demoteName,demoteIcon,empty,false)
else
EditMacro(demoteIndex,demoteName,demoteIcon,empty)
end

return
end

local name = player.name

local promoteBody =
"#showtooltip\n/gpromote "..name

local demoteBody =
"#showtooltip\n/gdemote "..name

if promoteIndex==0 then
CreateMacro(promoteName,promoteIcon,promoteBody,false)
else
EditMacro(promoteIndex,promoteName,promoteIcon,promoteBody)
end

if demoteIndex==0 then
CreateMacro(demoteName,demoteIcon,demoteBody,false)
else
EditMacro(demoteIndex,demoteName,demoteIcon,demoteBody)
end

end

-------------------------------------------------
-- IMPORT
-------------------------------------------------

importBtn:SetScript("OnClick",function()

if not RGT.targetRank then
print("Select target rank first")
return
end

C_GuildInfo.GuildRoster()

C_Timer.After(1,function()

RGT_BuildGuildMap()
RGT_BuildQueue()

end)

end)

-------------------------------------------------
-- QUEUE AUTO UPDATE ENGINE (FIXED)
-------------------------------------------------

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("GUILD_ROSTER_UPDATE")

eventFrame:SetScript("OnEvent",function()

if not RGT.queue[1] then return end

-- Roster neu anfordern
C_GuildInfo.GuildRoster()

C_Timer.After(0.8,function()

RGT_BuildGuildMap()

local short = Ambiguate(RGT.queue[1].name,"short")

local player = RGT.guildMap[strlower(short)]

if not player then return end

local newRank = player.rankIndex

-- erster Rang speichern
if not RGT.lastRankIndex then
RGT.lastRankIndex = newRank
return
end

-- Rang verändert
if newRank ~= RGT.lastRankIndex then

RGT.lastRankIndex = newRank

-- aktuellen Rang aktualisieren
RGT.queue[1].current = player.rank

-- Zielrang erreicht -> entfernen
if newRank == RGT.targetRankIndex then
table.remove(RGT.queue,1)
end

-- neuen Spieler vorbereiten
if RGT.queue[1] then

local nextShort = Ambiguate(RGT.queue[1].name,"short")
local nextPlayer = RGT.guildMap[strlower(nextShort)]

if nextPlayer then
RGT.lastRankIndex = nextPlayer.rankIndex
end

else
RGT.lastRankIndex = nil
end

RGT_UpdateUI()
RGT_UpdateMacro()

end

end)

end)

-------------------------------------------------
-- SLASH
-------------------------------------------------

SLASH_RGT1="/rgt"

SlashCmdList["RGT"]=function()

if frame:IsShown() then
frame:Hide()
else
frame:Show()
end

end