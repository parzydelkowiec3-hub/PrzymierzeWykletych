-- Addon: Przymierze Wykletych
-- Dla WoW 1.12.1

PrzymierzeWykletych = {}

PrzymierzeWykletych.messages = {
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

-- Domyslny interwal (15 minut)
local interval = 900
local timeSinceLast = 0

local frame = CreateFrame("Frame", "PrzymierzeWykletychFrame")
frame:RegisterEvent("VARIABLES_LOADED")

-- Losowe mowienie
function PrzymierzeWykletych_SayRandom()
local count = table.getn(PrzymierzeWykletych.messages)
if count > 0 then
    local msg = PrzymierzeWykletych.messages[math.random(1, count)]
    SendChatMessage(msg, "SAY")
    end
    end

    -- Wypisanie na czat
    local function Print(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[Przymierze Wykletych]|r " .. msg)
        end
        end

        -- Event po zaladowaniu zmiennych/addonu
        frame:SetScript("OnEvent", function()
        Print("Addon aktywny. Co " .. interval .. " sekund powie losowy tekst. (/mow, /mowtime <sekundy>)")
        PrzymierzeWykletych_SayRandom()
        end)

        -- Aktualizacja co frame
        frame:SetScript("OnUpdate", function()
        timeSinceLast = timeSinceLast + arg1
        if timeSinceLast >= interval then
            timeSinceLast = 0
            PrzymierzeWykletych_SayRandom()
            end
            end)

        -- Komenda /mow
        SlashCmdList = SlashCmdList or {}
        SLASH_MOW1 = "/mow"
        SlashCmdList["MOW"] = function()
        PrzymierzeWykletych_SayRandom()
        Print("Powiedziano losowy tekst.")
        end

        -- Komenda /mowtime <sekundy>
        SLASH_MOWTIME1 = "/mowtime"
        SlashCmdList["MOWTIME"] = function(msg)
        local t = tonumber(msg)
        if t and t > 0 then
            interval = t
            timeSinceLast = 0
            Print("Nowy interwal ustawiony na " .. t .. " sekund.")
            else
                Print("Uzycie: /mowtime <sekundy> (np. /mowtime 600)")
                end
                end
