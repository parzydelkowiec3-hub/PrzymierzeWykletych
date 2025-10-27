local Przymierzewykletych = {}
local interval = 60 -- 15 minut w sekundach
local elapsed = 0

Przymierzewykletych.messages = {
    "Gildia <PRZYMIERZE WYKLETYCH> zaprasza wszystkich odwaznych do wspolnej zabawy!",
    "Dolacz do gildii <PRZYMIERZE WYKLETYCH> i raiduj na MC/BWL/AQ/NAXX!",
    "Gildia <PRZYMIERZE WYKLETYCH> szuka graczy gotowych na epickie przygody!",
    "Nie przegap okazji! Gildia <PRZYMIERZE WYKLETYCH> rekrutuje nowych bohaterow!",
    "Z gildia <PRZYMIERZE WYKLETYCH> raidowanie staje sie przyjemnoscia!",
    "Gildia <PRZYMIERZE WYKLETYCH> czeka na Ciebie na kolejnych rajdach!",
    "Dolacz do gildii <PRZYMIERZE WYKLETYCH> i baw sie razem z nami na MC/BWL/AQ/NAXX!",
    "Szukasz aktywnej gildii? Gildia <PRZYMIERZE WYKLETYCH> ma dla Ciebie miejsce!",
    "Razem z gildia <PRZYMIERZE WYKLETYCH> osiagniemy wiecej – dolacz juz dzis!",
    "Gildia <PRZYMIERZE WYKLETYCH> zaprasza do wspolnej zabawy i raidow!"
}

-- Funkcja do losowego wyboru wiadomości
function Przymierzewykletych:GetRandomMessage()
local index = math.random(1, #self.messages)
return self.messages[index]
end

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function(self, delta)
elapsed = elapsed + delta
if elapsed >= interval then
    elapsed = 0
    Przymierzewykletych:DoAction()
    end
    end)

chatFrame:RegisterEvent("CHAT_MSG_SAY")
chatFrame:RegisterEvent("CHAT_MSG_PARTY")
chatFrame:SetScript("OnEvent", function(self, event, msg, sender, ...)
if msg == "!spam" then
    Przymierzewykletych:DoAction()
    end
    end)

function Przymierzewykletych:DoAction()
local message = self:GetRandomMessage()
-- Wysyłanie wiadomości do party
SendChatMessage(message, "World")
SendChatMessage(message, "world")
SendChatMessage(message, "YELL")
DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[PrzymierzeWykletych]|r " .. message)
end





DEFAULT_CHAT_FRAME:AddMessage("[PRZYMIERZE WYKLETYCH] ZALADOWAŁEM PANU ADDON!")
