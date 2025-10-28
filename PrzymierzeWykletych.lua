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

PrzymierzeWykletych.responsemsg = "Wcale nie 'jedyna', jest tez PRZYMIERZE WYKLETYCH! Zapraszamy!"

local interval = 900
local timeSinceLast = 0

local frame = CreateFrame("Frame", "PrzymierzeWykletychFrame")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("CHAT_MSG_CHANNEL")

-- Pomocnicza funkcja do logów
local function Print(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[Przymierze Wykletych]|r " .. msg)
    end
end

-- Funkcja losująca i wysyłająca wiadomość
function PrzymierzeWykletych_SayRandom()
    local count = #PrzymierzeWykletych.messages
    if count > 0 then
        local msg = PrzymierzeWykletych.messages[math.random(1, count)]
        SendChatMessage(msg, "YELL")
        SendChatMessage(msg, "CHANNEL", nil, 5)
        SendChatMessage(msg, "CHANNEL", nil, 4)
    end
end

-- Obsługa eventów
frame:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg9)
    if event == "VARIABLES_LOADED" then
        Print("Addon aktywny. Co " .. interval .. " sekund powie losowy tekst. (/mow, /mowtime <sekundy>)")
        PrzymierzeWykletych_SayRandom()
    elseif event == "CHAT_MSG_CHANNEL" then
        local msg, sender, language, channelName = arg1, arg2, arg3, arg9
        if string.lower(channelName or "") == "world" then
            local text = string.lower(msg)
            if string.find(text, "zmiana warty") and string.find(text, "jedyna") then
                SendChatMessage(PrzymierzeWykletych.responsemsg, "CHANNEL", nil, 5)
                SendChatMessage(PrzymierzeWykletych.responsemsg, "CHANNEL", nil, 4)
            end
        end
    end
end)

-- Aktualizacja co frame
frame:SetScript("OnUpdate", function(self, elapsed)
    timeSinceLast = timeSinceLast + elapsed
    if timeSinceLast >= interval then
        timeSinceLast = 0
        PrzymierzeWykletych_SayRandom()
    end
end)

-- Komenda /mow
SlashCmdList["MOW"] = function()
    PrzymierzeWykletych_SayRandom()
    Print("Powiedziano losowy tekst.")
end
SLASH_MOW1 = "/mow"

-- Komenda /mowtime <sekundy>
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
SLASH_MOWTIME1 = "/mowtime"
