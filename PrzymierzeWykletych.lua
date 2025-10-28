-- Addon: Przymierze Wykletych
-- Dla WoW 1.12.1 (pełna kompatybilność)

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

PrzymierzeWykletych.responsemsg = "Wcale nie 'jedyna', jest tez polsko-czeska gildia PRZYMIERZE WYKLETYCH! Ahoj!"

local interval = 900
local timeSinceLast = 0
local initialized = false
local reponseEnabled = false
local spamFrequency = 0.0

local frame = CreateFrame("Frame", "PrzymierzeWykletychFrame")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("CHAT_MSG_CHANNEL")

local function Print(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[Przymierze Wykletych]|r " .. msg)
    end
end

function PrzymierzeWykletych_SayRandom()
    local count = table.getn(PrzymierzeWykletych.messages)
    if count > 0 then
        local msg = PrzymierzeWykletych.messages[math.random(1, count)]
        SendChatMessage(msg, "YELL")
        pcall(SendChatMessage, msg, "CHANNEL", nil, 5)
        pcall(SendChatMessage, msg, "CHANNEL", nil, 4)
    end
end

frame:SetScript("OnEvent", function()
    if event == "VARIABLES_LOADED" then
        if initialized then return end
        initialized = true
        Print("Addon aktywny. Co " .. interval .. " sekund powie losowy tekst. (/mow, /mowtime <sekundy>)")
        PrzymierzeWykletych_SayRandom()
    elseif event == "CHAT_MSG_CHANNEL" then
        local msg, sender, language, channelName = arg1, arg2, arg3, arg9
        if string.lower(channelName or "") == "world" then
            local text = string.lower(msg or "")
            if string.find(text, "zmiana warty") and string.find(text, "jedyna") and reponseEnabled then
                pcall(SendChatMessage, PrzymierzeWykletych.responsemsg, "CHANNEL", nil, 5)
                pcall(SendChatMessage, PrzymierzeWykletych.responsemsg, "CHANNEL", nil, 4)
            end
        end
    end
end)

frame:SetScript("OnUpdate", function()
    timeSinceLast = timeSinceLast + arg1
    if timeSinceLast >= interval then
        timeSinceLast = 0
        PrzymierzeWykletych_SayRandom()
    end
end)

SlashCmdList = SlashCmdList or {}

SLASH_MOW1 = "/mow"
SlashCmdList["MOW"] = function()
    PrzymierzeWykletych_SayRandom()
    Print("Powiedziano losowy tekst.")
end

SLASH_MOW1 = "/mowresptoggle"
SlashCmdList["MOWRESPTOGGLE"] = function()
    responseEnabled = not responseEnabled
    Print("Responder na Zmiane Warty ustawiony na " .. str(responseEnabled) .. " .")
end

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

SLASH_MOWHELP1 = "/mowhelp"
SlashCmdList["MOWHELP"] = function()
    Print("Dostepne komendy: /mow, /mowtime <sekundy>, /mowresptoggle /mowhelp.")
    Print("/mow - odpala od razu tekst na reklame")
    Print("/mowtime <sekundy> - konfiguruje pluign do uzytkowania jedynie co jakis czas (900 - 15 minut, 1800 - 30 minut, domyślnie - 15 minut)")
    Print("/mowresptoggle - włącza/wyłącza resp toggler na Zmiane Warty")
    Print("/mowhelp - wypirintowuje to co czytasz teraz")
end
