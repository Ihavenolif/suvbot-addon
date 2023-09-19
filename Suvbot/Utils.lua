local _, ns = ...

Utils = {
    split = function (inputstr, sep)
        if sep == nil then
            sep = " "
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end,
    tableContains = function(table, element)
        for _, value in pairs(table) do
            if value == element then
                return true
            end
        end
        return false
    end,
    firstToUpper = function (str)
        return (str:gsub("^%l", string.upper))
    end
}

ns.utils = Utils
ns.nadavky = {"kokot", "zmrd", "čůrák", "dement", "mentál", "fagot", "potrat", "nerd", "hovno", "hovnožrout", "zhovnagolem", "buzík", "krypl", "kretén", "píčus", "analfabet", "primitiv", "hovnojed", "feťák", "retard", "smrad", "debil", "kokůtek", "frajírek"}
ns.pridJm = {"dementní", "vyjebanej", "zkurvenej", "zasranej", "vypíčenej", "zpíčenej", "tlustej", "špekatej", "primitivní", "impotentní", "teplej", "potracenej", "vyprcanej", "nafoukanej", "vyhulenej", "smradlavej", "špinavej", "arogantní", "zajebanej", "zachcanej"}
ns.osoba1 = {"jenom na všechny řve", "akorát každýho kritizuje", "stejně neumí hrát svojí classu", "akorát parsuje na píču", "si o sobě myslí jak je dobrej, i když je to nula", "ani neumí vyprat polštář", "to v životě stejně nikam nedotáhne", "neumí sám ani vylézt z vany", "zvládne akorát po sobě slintat", "by bez maminky vůbec nepřežil", "by ode mě dostal v reálu přes držku", "by si v reálu ani nedovolil na mě promluvit"}
ns.osoba2 = {"jít zabít", "jít vysrat", "KYS", "jít oběsit", "jít zastřelit", "ubrečet", "uhonit k smrti", "jít vybrečet, protože ti budu chybět", "naučit parsovat", "třeba posrat"}
ns.misto = {"do prdele", "do řiti", "do kundy", "do píči", "do zadku", "víte kam", "třeba na Slovensko", "do Prešova", "do Brna", "do Lesiho mámy", "do Zeddovo tlustý prdele", "do díry"}
ns.guilda = {"dostanete cancer", "všichni shoříte", "nezabijete ani prvního bosse na mythic", "nedoděláte ani curvu", "všichni commitnete noliving", "dostanete ban", "všichni chcípnete", "všichni chcípnete na sars", "vám všichni leavnou", "vám Eternal Shadows vojedou mámy", "mě vezmete zpátky", "vám tu posranou guildu zruší", "nesložíte ani jeden raid", "vás bude málo", "se rozpadnete", "budete raidovat maximálně LFR", "vám shoří počítače", "vás vypoachujou Eternal Shadows"}

ns.sklon5p = function(text)
    function string.ends(str, ending)
        return ending == "" or str:sub(-#ending) == ending
    end
    
    local sklon = text
    
    if string.ends(text, "a") or string.ends(text, "u") then
        sklon = text:sub(0,#text-1) .. "o"
    elseif string.ends(text, "ec") then
        sklon = text:sub(0,#text-2) .. "če"
    elseif string.ends(text, "c") then
        sklon = text:sub(0,#text-1) .. "če"
    elseif string.ends(text, "ek") then
        sklon = text:sub(0,#text-2) .. "ku"
    elseif string.ends(text, "ph") then
        sklon = sklon .. "e"
    elseif string.ends(text, "s") or string.ends(text, "š") or string.ends(text, "x") or string.ends(text, "j") or string.ends(text, "č") or string.ends(text, "ř") then
        sklon = sklon .. "i"
    elseif string.ends(text, "g") or string.ends(text, "h") or string.ends(text, "k") or string.ends(text, "q") then
        sklon = sklon .. "u"
    elseif string.ends(text, "i") or string.ends(text, "í") or string.ends(text, "e") or string.ends(text, "é") or string.ends(text, "o") or string.ends(text, "y") or string.ends(text, "á") then
        sklon = text
    else
        sklon = sklon .. "e"
    end
    
    return sklon
end
