local MyTimerAddon = {}
local interval = 900 -- 15 minut w sekundach
local elapsed = 0

MyTimerAddon.messages = {
    "Gildia <PRZYMIERZE WYKLETYCH> zaprasza wszystkich odważnych do wspólnej zabawy!",
    "Dołącz do gildii <PRZYMIERZE WYKLETYCH> i raiduj na MC/BWL/AQ/NAXX!",
    "Gildia <PRZYMIERZE WYKLETYCH> szuka graczy gotowych na epickie przygody!",
    "Nie przegap okazji! Gildia <PRZYMIERZE WYKLETYCH> rekrutuje nowych bohaterów!",
    "Z gildia <PRZYMIERZE WYKLETYCH> raidowanie staje się przyjemnością!",
    "Gildia <PRZYMIERZE WYKLETYCH> czeka na Ciebie na kolejnych rajdach!",
    "Dołącz do gildii <PRZYMIERZE WYKLETYCH> i baw się razem z nami na MC/BWL/AQ/NAXX!",
    "Szukasz aktywnej gildii? Gildia <PRZYMIERZE WYKLETYCH> ma dla Ciebie miejsce!",
    "Razem z gildia <PRZYMIERZE WYKLETYCH> osiągniemy więcej – dołącz już dziś!",
    "Gildia <PRZYMIERZE WYKLETYCH> zaprasza do wspólnej zabawy i raidów!"
}


-- Funkcja do losowego wyboru wiadomości
function MyTimerAddon:GetRandomMessage()
local index = math.random(1, #self.messages)
return self.messages[index]
end

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function(self, delta)
elapsed = elapsed + delta
if elapsed >= interval then
    elapsed = 0
    MyTimerAddon:DoAction()
    end
    end)

function MyTimerAddon:DoAction()
local message = self:GetRandomMessage()
-- Wysyłanie wiadomości do party
SendChatMessage(message, "PARTY")
DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[PrzymierzeWykletych]|r " .. message)
end
