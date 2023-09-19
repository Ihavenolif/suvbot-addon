local _, ns = ...

local selectorValues = {
    [1] = "SAY",
    [2] = "YELL",
    [3] = "PARTY",
    [4] = "GUILD",
    [5] = "RAID",
    [6] = "WHISPER"
}

Suvbot = LibStub("AceAddon-3.0"):NewAddon("Suvbot", "AceConsole-3.0", "AceEvent-3.0")

function Suvbot:OnInitialize()
	-- Called when the addon is loaded
    self:RegisterChatCommand("insult", "Insult")
    self:RegisterChatCommand("test", "Test")
    self:RegisterChatCommand("leaveguld", "LeaveGuld")
end

function Suvbot:OnEnable()
	-- Called when the addon is enabled
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
end

function Suvbot:OnDisable()
	-- Called when the addon is disabled
end

function Suvbot:PLAYER_TARGET_CHANGED()
    if not InsultFrame then
        return
    end
    TargetBox:SetText(UnitName("target"))
end

function Suvbot:Insult(msg)
    local args = ns.utils.split(msg, " ")
    if not args[1] then
        InsultUI()
        return
    end
    local channel = string.upper(args[1])

    if not ns.utils.tableContains(selectorValues, channel) then
        self:Print("Chyba ve výběru chat kanálu.")
        return
    end

    local target = args[2]
    if target == nil then
        target = UnitName("target")
    end
    if target == nil then
        self:Print("Je potřeba zadat koho chceš urazit, nebo mít někoho v targetu.")
        return
    end

    Insult(target, channel)
end

function Suvbot:LeaveGuld(msg)
    if not IsInGuild() then
        self:Print("Nejsi v žádné guildě.")
        --UNCOMMENT NA VLASTNÍ RIZIKO
        --SendChatMessage("AHOJ RÁD BICH SE PŘIDAL DO VAŠÍ GILDI", "WHISPER", GetDefaultLanguage("player"), "Ahaferos-Drak'thul")
        return
    end

    local args = ns.utils.split(msg, " ")
    if not args[1] or not args[2] then
        self:Print("Je potřeba zadat kvůli komu leavuješ.")
        self:Print("/leaveguld osoba1 osoba2")
        return
    end

    local osoba1 = ns.utils.firstToUpper(args[1])
    local osoba2 = ns.sklon5p(ns.utils.firstToUpper(args[2]))
    local os1 = ns.osoba1[math.random(#ns.osoba1)]
    local os2 = ns.osoba2[math.random(#ns.osoba2)]
    local nadFirst = ns.nadavky[math.random(#ns.nadavky)]
    local nadSecond = ns.nadavky[math.random(#ns.nadavky)]
    while(nadFirst == nadSecond) do
        nadSecond = ns.nadavky[math.random(#ns.nadavky)]
    end
    local pridJm1 = ns.pridJm[math.random(#ns.pridJm)]
    local pridJm2 = ns.pridJm[math.random(#ns.pridJm)]
    while(pridJm1 == pridJm2) do
        pridJm2 = ns.pridJm[math.random(#ns.pridJm)]
    end
    local nadTy = ns.sklon5p(ns.nadavky[math.random(#ns.nadavky)])
    local nadLast = ns.sklon5p(ns.nadavky[math.random(#ns.nadavky)])
    while(pridJm1 == pridJm2) do
        nadLast = ns.sklon5p(ns.nadavky[math.random(#ns.nadavky)])
    end
    local nadS = ns.nadavky[math.random(#ns.nadavky)] .. "em"
    local guilda = ns.guilda[math.random(#ns.guilda)]
    local misto = ns.misto[math.random(#ns.misto)]

    local leaveStr1 = "Ahoj, rozhodl jsem se leavnout guildu, protože " .. osoba1 .. " je " .. nadFirst .. " a " .. pridJm1 .. " " .. nadSecond .. ", který " .. os1 .. ". Hraju to už " .. math.random(5,51) .. " let a s takovým " .. nadS .. " jsem se ještě nesetkal."
    local leaveStr2 = "Doufám, že v příštím tieru " .. guilda .. ". Strčte si vaší guildu " .. misto .. ", jdu mít " .. math.random(1,51) .. " parsy jinam! A " .. osoba2 .. " ty " .. pridJm2 .. " " .. nadTy .. " se taky můžeš " .. os2 .. " ty " .. nadLast .. "!"
    SendChatMessage(leaveStr1,"GUILD")
    SendChatMessage(leaveStr2,"GUILD")
    --GuildLeave() protected, bohužel
end

function InsultUI()
    local AceGUI = LibStub("AceGUI-3.0")
    -- Create a container frame
    InsultFrame = AceGUI:Create("Frame")
    InsultFrame:SetCallback("OnClose",function(widget) AceGUI:Release(widget) end)
    InsultFrame:SetTitle("Insult interface")
    InsultFrame:SetAutoAdjustHeight(true)

    _G["MyGlobalFrameName"] = InsultFrame.frame
    tinsert(UISpecialFrames, "MyGlobalFrameName")

    local targetLabel = AceGUI:Create("InteractiveLabel")
    targetLabel:SetText("Target")

    local channelSelector = AceGUI:Create("Dropdown")
    channelSelector:SetList({"Say", "Yell", "Party", "Guild", "Raid", "Whisper"})

    local btn = AceGUI:Create("Button")
    btn:SetWidth(170)
    btn:SetText("Send!")
    btn:SetCallback("OnClick", function()
        if channelSelector:GetValue() and (not (TargetBox:GetText() == "")) then
            Insult(TargetBox:GetText(), selectorValues[channelSelector:GetValue()])
        else
            Suvbot:Print("Musíš zadat koho chceš urazit a v jakém kanálu.")
        end
    end)

    TargetBox = AceGUI:Create("EditBox")

    InsultFrame:AddChild(targetLabel)
    InsultFrame:AddChild(TargetBox)
    InsultFrame:AddChild(channelSelector)
    InsultFrame:AddChild(btn)
end

function Insult(target, channel)
    local pridJm1 = ns.pridJm[math.random(#ns.pridJm)]
    local pridJm2 = ns.pridJm[math.random(#ns.pridJm)]
    while(pridJm1 == pridJm2) do
        pridJm2 = ns.pridJm[math.random(#ns.pridJm)]
    end
    local nadavka = ns.nadavky[math.random(#ns.nadavky)]

    if channel == "WHISPER" then
        local name, realm = UnitName("target")
        if not realm then
            SendChatMessage(ns.sklon5p(target) .. ", ty " .. pridJm1 .. " " .. pridJm2 .. " " .. ns.sklon5p(nadavka) .. "!",channel,GetDefaultLanguage("player"),target)
        else
            SendChatMessage(ns.sklon5p(target) .. ", ty " .. pridJm1 .. " " .. pridJm2 .. " " .. ns.sklon5p(nadavka) .. "!",channel,GetDefaultLanguage("player"),name .. "-" .. realm)
        end
        return
    end

    SendChatMessage(ns.sklon5p(target) .. ", ty " .. pridJm1 .. " " .. pridJm2 .. " " .. ns.sklon5p(nadavka) .. "!",channel)
end
