script_author("McWood")
script_version('03.12.2021')

require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require "imgui"
local encoding = require "encoding"
encoding.default = 'CP1251'
u8 = encoding.UTF8
local rkeys = require 'rkeys'
local gkey = require 'game.keys'
imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar

update_state = false

local themes = import "resource/imgui_themes.lua"
local checked_radio = imgui.ImInt(1)

local label = 0
local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local sw, sh = getScreenResolution()
local women = imgui.ImBool(false)
toggle_status = imgui.ImBool(false)
toggle_status_1 = imgui.ImBool(false)

local script_vers = 8
local script_vers_text = "8.1"

local update_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/BindCNN10.lua"
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

    health = getCharHealth(PLAYER_PED)

    sampAddChatMessage("Áèíäåð äëÿ CNN", main_color)

    sampRegisterChatCommand("bmenu", cmd_bmenu)
    sampRegisterChatCommand("invv", invv)
    sampRegisterChatCommand("clearchat", clearchat)
    sampRegisterChatCommand("update", cmd_update)


    imgui.Process = false

    imgui.SwitchContext()
    themes.SwitchColorTheme()

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Åñòü îáíîâëåíèå! Âåðñèÿ: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

    while true do
        wait(0)

        _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        nick = sampGetPlayerNickname(id)

        if main_window_state.v == false then
            imgui.Process = false
        end

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("Ñêðèïò óñïåøíî îáíîâëåí!", -1)
                    thisScript():reload()
                end
            end)
            break
        end

    end
end

function cmd_bmenu(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end

function clearchat(arg)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
    sampAddChatMessage("   ", -1)
end

function invv(arg)
    local _,  ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)

    lua_thread.create(function ()
    if not women.v == true then
        sampSendChat("Çäðàâñòâóéòå, âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå?")
        wait(2000)
        sampAddChatMessage("Äëÿ ïðîäîëæåíèÿ íàæìèòå -1; Äëÿ îòìåòû íàæìèòå - 2", 0xFF8C00)
        wait(2000)
        repeat
        wait(10)
        if isKeyJustPressed(VK_2) then
            sampAddChatMessage("Óñïåøíî îòìåíåíî", main_color)
        return
        end
        until isKeyJustPressed(VK_1)
        sampSendChat("Õîðîøî, ïîêàæèòå âàøè äîêóìåíòû, à èìåííî: ïàñïîðò, ìåä.êàðòó è ëèöåíçèè")
        wait(2000)
        sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
        wait(2000)
        sampAddChatMessage("Äëÿ ïðîäîëæåíèÿ íàæìèòå -1; Äëÿ îòìåòû íàæìèòå - 2", 0xFF8C00)
        wait(2000)
        repeat
        wait(10)
        if isKeyJustPressed(VK_2) then
            sampAddChatMessage("Óñïåøíî îòìåíåíî", main_color)
        return
        end
        until isKeyJustPressed(VK_1)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ðóêè âçÿë äîêóìåíòû ó ÷åëîâåêà íàïðîòèâ")
        wait(2000)
        sampSendChat("/todo Òàê, õîðîøî, ýòî åñòü...*îñìîòðåâ äîêóìåíòû")
        wait(2000)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ðóêè âåðíóë äîêóìåíòû ÷åëîâåêó íàïðîòèâ")
        wait(2000)
        sampAddChatMessage("Ïîäõîäèò - 1; Íå ïîäõîäèò - 2", 0xFF8C00)
        wait(2000)
        repeat
        wait(10)
        if isKeyJustPressed(VK_2) then
            sampSendChat("Ê ñîæàëåíèþ, Âû íàì íå ïîäõîäèòå.")
        return
        end
        until isKeyJustPressed(VK_1)
        sampSendChat("Îòëè÷íî. Âû íàì ïîäõîäèòå. Ñåé÷àñ ÿ âûäàì Âàì ôîðìó è êëþ÷ îò øêàô÷èêà")
        wait(2000)
        sampSendChat("/me ïëàâíî íàêëîíèëñÿ â ñòîðîíó ÿùèêà îò ñòîéêè è ïðèîòêðûâ åãî...")
        wait(2000)
        sampSendChat("/me ...âçÿë ôîðìó è êëþ÷ íîìåð " ..idpl)
        wait(2000)
        sampSendChat("Óäà÷íîé Âàì ðàáîòû!")
        end

    if not women.v == false then
        sampSendChat("Çäðàâñòâóéòå, âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå?")
        wait(2000)
        sampAddChatMessage("Äëÿ ïðîäîëæåíèÿ íàæìèòå -1; Äëÿ îòìåòû íàæìèòå - 2", 0xFF8C00)
        wait(2000)
        repeat
        wait(10)
        if isKeyJustPressed(VK_2) then
            sampAddChatMessage("Óñïåøíî îòìåíåíî", main_color)
        return
        end
        until isKeyJustPressed(VK_1)
        sampSendChat("Õîðîøî, ïîêàæèòå âàøè äîêóìåíòû, à èìåííî: ïàñïîðò, ìåä.êàðòó è ëèöåíçèè")
        wait(2000)
        sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
        wait(2000)
        sampAddChatMessage("Äëÿ ïðîäîëæåíèÿ íàæìèòå -1; Äëÿ îòìåòû íàæìèòå - 2", 0xFF8C00)
        wait(2000)
        repeat
        wait(10)
        if isKeyJustPressed(VK_2) then
            sampAddChatMessage("Óñïåøíî îòìåíåíî", main_color)
        return
        end
        until isKeyJustPressed(VK_1)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ðóêè âçÿëà äîêóìåíòû ó ÷åëîâåêà íàïðîòèâ")
        wait(2000)
        sampSendChat("/todo Òàê, õîðîøî, ýòî åñòü...*îñìîòðåâ äîêóìåíòû")
        wait(2000)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ðóêè âåðíóëà äîêóìåíòû ÷åëîâåêó íàïðîòèâ")
        wait(2000)
        sampAddChatMessage("Ïîäõîäèò - 1; Íå ïîäõîäèò - 2", 0xFF8C00)
        wait(2000)
        repeat
        wait(10)
        if isKeyJustPressed(VK_2) then
            sampSendChat("Ê ñîæàëåíèþ, Âû íàì íå ïîäõîäèòå.")
        return
        end
        until isKeyJustPressed(VK_1)
        sampSendChat("Îòëè÷íî. Âû íàì ïîäõîäèòå. Ñåé÷àñ ÿ âûäàì Âàì ôîðìó è êëþ÷ îò øêàô÷èêà")
        wait(2000)
        sampSendChat("/me ïëàâíî íàêëîíèëàñü â ñòîðîíó ÿùèêà îò ñòîéêè è ïðèîòêðûâ åãî...")
        wait(2000)
        sampSendChat("/me ...âçÿëà ôîðìó è êëþ÷ íîìåð " ..idpl)
        wait(2000)
        sampSendChat("Óäà÷íîé Âàì ðàáîòû!")
    end
    end)
end


function imgui.OnDrawFrame()

    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.SetNextWindowSize(imgui.ImVec2(620, 650), imgui.Cond.FirstUseEver)
    imgui.Begin(u8"BindCNN", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    imgui.TextColored(imgui.ImVec4(0, 1, 0, 1), u8'Âåðñèÿ: ' .. updateIni.info.vers_text)
        -- Îñíîâíîå
    imgui.BeginChild('##1', imgui.ImVec2(200, 175), true)
        imgui.Text(u8"Âàø íèê: " ..nick.. "[" ..id.. "]")
        imgui.Checkbox(u8"Æåíñêèå îòûãðîâêè", women)
		imgui.SameLine()
		imgui.TextQuestion("( ? )",u8"Áóäóò îòûãðûâàòüñÿ æåíñêèå îòûãðîâêè")
    imgui.EndChild()
    
        -- Òåìû
    imgui.SetCursorPos(imgui.ImVec2(210, 43))
    imgui.BeginChild('##2', imgui.ImVec2(200, 175), true)
        for i, value in ipairs(themes.colorTheme) do
            if imgui.RadioButton(value, checked_radio, i) then
                themes.SwitchColorTheme(i)
            end
        end
    imgui.EndChild()
        -- Êîìàíäû
    imgui.SetCursorPos(imgui.ImVec2(5, 220))
    imgui.BeginChild('##3', imgui.ImVec2(200, 175), true)
    imgui.Text(u8"/bmenu - ìåíþ ñêðèïòà\n/invv - ïðèíÿòèå èãðîêà")
    imgui.EndChild()
        -- Ëåêöèè
    imgui.SetCursorPos(imgui.ImVec2(415, 43))
    imgui.BeginChild('##4', imgui.ImVec2(200, 175), true)
        if imgui.Button(u8'Ëåêöèÿ 1 - Ñïåö.Ðàöèÿ', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("/r Çäðàâñòâóéòå, äîðîãèå êîëëåãè!")
                wait(2000)
                sampSendChat("/r Ñåé÷àñ ÿ õî÷ó âàì ðàññêàçàòü î íàøåé 'Ñïåö ðàöèè Äèñêîðä'.")
                wait(2000)
                sampSendChat("/r Äàííàÿ ñïåö. ðàöèÿ íóæíà íóæíà àáñîëþòíî âñåì ñîòðóäíèêàì, âêëþ÷àÿ è ñòàæ¸ðîâ.")
                wait(2000)
                sampSendChat("/r Îíà ïðåäíàçíà÷åíà äëÿ áûñòðîé ïåðåäà÷è èíôîðìàöèè ìåæäó ñîòðóäíèêàìè")
                wait(2000)
                sampSendChat("/r Òàê-æå ïîäêëþ÷èòü å¸ î÷åíü ïðîñòî")
                wait(2000)
                sampSendChat("/rb Âñå î÷åíü ïðîñòî! Äëÿ òåõ ó êîãî íåòó - https://discord.gg/brainburg")
                wait(2000)
                sampSendChat("/rb Äåëàåì íèê ïî ôîðìå [CNN LS][1] Nick_Name")
                wait(2000)
                sampSendChat("/rb ïèøåì â êàíàë #çàïðîñ-ðîëè è íàæèìàåì êíîïêó 'Çàïðîñèòü ðîëü îðãàíèçàöèè'")
                wait(2000)
                sampSendChat("/rb ïîñëå òîãî êàê âàì âûäàäóò ðîëü ëèñòàåì íèæå è ïîäêëþ÷àåìñÿ â êàíàë ÑÌÈ | LVFM")
                wait(2000)
            end)
        end
        if imgui.Button(u8'Ëåêöèÿ 2 - Ñóáîðäèíàöèÿ', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("Çäðàâñòâóéòå, äîðîãèå êîëëåãè!")
                wait(2000)
                sampSendChat("Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó 'Ñóáîðäèíàöèÿ'.")
                wait(2000)
                sampSendChat("Ñóáîðäèíàöèÿ - ýòî ïðàâèëî îáùåíèÿ ìåæäó ëþäüìè")
                wait(2000)
                sampSendChat("Â íàøåì ðàäèîöåíòðå îáùåíèå ñòðîãî íà Âû!")
                wait(2000)
                sampSendChat("Âû îáÿçàíû ñ îáùàòüñÿ ñ ïîñåòèòåëÿìè ðàäèîöåíòðàìè óâàæèòåëüíî.")
                wait(2000)
                sampSendChat("Ñ êîëëåãàìè âû òàê æå îáÿçàíû îòíîñèòüñÿ íà Âû")
                wait(2000)
                sampSendChat("Íà ýòîì ëåêöèÿ íà òåìó 'Ñóáîðäèíàöèÿ' îêîí÷åíà")
                wait(2000)
            end)
        end
        if imgui.Button(u8'Ëåêöèÿ 3 - Ï.Ð.Î', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("Çäðàâñòâóéòå, äîðîãèå êîëëåãè!")
                wait(2000)
                sampSendChat("Ñåé÷àñ ÿ âàì ïðîâåäó ëåêöèþ íà òåìó 'Ï.Ð.Î'")
                wait(2000)
                sampSendChat("'Ï.Ð.Î' - Ïðàâèëî Ðåäàêòèðîâàíèÿ Îáúÿâëåíèé.")
                wait(2000)
                sampSendChat("Êàæäûé ñîòðóäíèê íàøåãî ðàäèîöåíòðà îáÿçàí çíàòü...")
                wait(2000)
                sampSendChat("...÷òî òàêîå Ï.Ð.Î, è ãäå åãî ïðèìåíÿòü.")
                wait(2000)
                sampSendChat("Â ñëó÷àå åñëè ñîòðóäíèê íå çíàåò Ï.Ð.Î, íà íåãî áóäóò íàëîæåíû ñàíêöèè...")
                wait(2000)
                sampSendChat(".. òàêèå êàê: óñòíîå ïðåäóïðåæäåíèå, âûãîâîð, ïîíèæåíèå, óâîëüíåíèå.")
                wait(2000)
                sampSendChat("Áîëåå ïîäðîáíî ñ ýòèìè ïðàâèëàìè âû ìîæåòå îçíàêîìèòüñÿ ÷åðåç îôô.ïîðòàë øòàòà.")
                wait(2000)
                sampSendChat("/b Ïóòü ê ýòèì ïðàâèëàì-> forum.arizona-rp.com")
                wait(2000)
                sampSendChat("/b Ôîðóì -> Ñåðâåð ¹5 [ Brainburg ] -> Ãîñ.ñòðóêòóðû")
                wait(2000)
                sampSendChat("/b -> Mass Media | Ñðåäñòâà Ìàññîâîé Èíôîðìàöèè -> Ïðàâèëà Ðåäàêòèðîâàíèÿ Îáúÿâëåíèé")
                wait(2000)
            end)
        end
        if imgui.Button(u8'Ëåêöèÿ 4 - Ãàçåòà', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("Óâàæàåìûå êîëëåãè, ìèíóòî÷êó âíèìàíèÿ, ñåé÷àñ ÿ ïðîâåäó âàì ëåêöèþ íà òåìó 'Ãàçåòà'")
                wait(2000)
                sampSendChat("Ãàçåòà - ïèñüìåííîå ñîäåðæàíèå ïðîèñõîäÿùåãî. Â ãàçåòå ìîæåò áûòü ëþáàÿ òåìà...")
                wait(2000)
                sampSendChat("... áóäü òî ðàññêàç î òðàíñïîðòå, ñâîäêà î ðàáîòå, ðåêëàìà ÷åãî ëèáî, à òàê æå èíôîðìàöèÿ î ïîãîäå.")
                wait(2000)
                sampSendChat("Äëÿ òîãî ÷òî-áû äåëàòü ãàçåòû íóæíî èìåòü æåëàíèå, à òàê æå ïðèíòåð!")
                wait(2000)
                sampSendChat("/b Íàì ïîíàäîáèòñÿ ôîòîøîï!")
                wait(2000)
                sampSendChat("Äëÿ ëþáîé ãàçåòû íåîáõîäèìà áóìàãà!")
                wait(2000)
                sampSendChat("/b Ôîí ãàçåòû ìîæåòå çàïðîñèòü ó ëèäåðà ñâîåé îðãàíèçàöèè.")
                wait(2000)
                sampSendChat("Äëÿ óäîáñòâà âûïóñêà ãàçåòû, âû ìîæåòå äåëàòü ôîòîðåïîðòàæè.")
                wait(2000)
                sampSendChat("/b Äåëàåòå ñêðèíøîò ÷åãî ëèáî, è âñòàâëÿåòå â øàáëîí ãàçåòû.")
                wait(2000)
                sampSendChat("Äëÿ âàøåãî óäîáñòâà ó íàñ åñòü êàðàíäàøè.")
                wait(2000)
                sampSendChat("/b Ïîñëå çàãðóçêè âñåõ ôîòîãðàôèé, íà øàáëîíå ïèøåòå ñöåíàðèé ãàçåòû.")
                wait(2000)
                sampSendChat("Ïîñëå òîãî êàê âû âñå ñäåëàëè, âû ìîæåòå âîñïîëüçîâàòüñÿ ïðèíòåðîì è ðàñïå÷àòàòü ïàðî÷êó ãàçåò.")
                wait(2000)
                sampSendChat("/b Ñîõðàíÿåì ïîëó÷åííîå äåéñòâèå.")
                wait(2000)
                sampSendChat("Ëåêöèÿ íà òåìó 'Ãàçåòà' îêîí÷åíà.")
                wait(2000)
            end)
        end
        if imgui.Button(u8'Âûäà÷à ëèñòîâîê', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("/do Ñóìêà íà ïëå÷å.")
                wait(2000)
                sampSendChat("/me äâèæåíèåì ðóêè ïîâåðíóë ñóìêó ê ñåáå")
                wait(2000)
                sampSendChat("/do Âçãëÿä íà ñóìêå.")
                wait(2000)
                sampSendChat("/me ïðàâîé ðóêîé ïîòÿíóë çà çàìîê ñóìêè")
                wait(2000)
                sampSendChat("/do Ñóìêà îòêðûòà.")
                wait(2000)
                sampSendChat("/do Â ñóìêå ïðèãëàøåíèå â Ðàäèîöåíòð ã.Ëàñ-Âåíòóðà")
                wait(2000)
                sampSendChat("/todo Âîò äåðæèòå*ïåðåäàâàÿ ëèñòîâêó ÷åëîâåêó íà ïðîòèâ")
                wait(2000)
                sampSendChat("/do Â ëèñòîâêå íàïèñàíî")
                wait(2000)
                sampSendChat("/do Áîëüøàÿ çàðïëàòà, âåñåëàÿ ðîáîòà, âåñåëûå ñîòðóäíèêè")
                wait(2000)
                sampSendChat("/do Ñîáåñåäîâàíèå â Õîëëå Ðàäèîöåíòðå.")
                wait(2000)
            end)
        end
    imgui.EndChild()
		--Äðóãèå ñíîñêè, êíîïêè
	imgui.SetCursorPos(imgui.ImVec2(210, 220))
	imgui.BeginChild('##5', imgui.ImVec2(200, 175), true)
	if imgui.Button(u8'Ýôèð â ÑÌÈ ËÂ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news °°°° Ìóçûêàëüíàÿ çàñòàâêà Ðàäèîöåíòðà ã.Ëàñ-Âåíòóðàñ °°°°")
			wait(6000)
			sampSendChat("/news Äîáðîãî âðåìåíè ñóòîê óâàæàåìûå æèòåëè øòàòà.")
			wait(6000)
			sampSendChat("/news Ìû ïðèãëàøàåì âàñ íà ñîáåñåäîâàíèå â Ðàäèîöåíòð ÑÌÈ ã.Ëàñ-Âåíòóðàñ.")
			wait(6000)
			sampSendChat("/news Òàê æå, ìû âûäà¸ì ëó÷øèì ñîòðóäíèêàì äíÿ åæåäíåâíûå ïðåìèè îò 200.000$.")
			wait(6000)
			sampSendChat("/news Äîáðûé è îòçû÷èâîé êîëåêòèâ êîòîðûé âñ¸ãäà áóäåò âàì ïîìîãàòü.")
			wait(6000)
			sampSendChat("/news Êîãäà ìíîãî ðîáîòíèêîâ ó íàñ òîãäà ÷àñòî ïðîõîäÿò ìåðîïðèÿòèÿ ñ ïðèçàìè.")
			wait(6000)
			sampSendChat("/news Çäåñü âû ñìîæåòå ÷óñòâîâàòü ñåáÿ âàæíîé ëè÷íîñòüþ.")
			wait(6000)
			sampSendChat("/news À òàêæå ïðè äîñòèæåíèè 'Ð¸ïîðòåð' âû ñìîæåòå ïðîâîäèòü ýôèðû.")
			wait(6000)
			sampSendChat("/news Íà êîòîðûõ ñìîæåòå çàðîáîòàòü îò 1.000.000$ äî 5.000.000$")
			wait(6000)
			sampSendChat("/news ×åì áûñòðåå âû ê íàì óñòðîèòåñü òåì áûñòðåå íà÷í¸òå æèòü â óäîâîëüñòâèå.")
			wait(6000)
			sampSendChat("/news ×òîáû óñòðîèòñÿ ê íàì íà ðàáîòó âàì íóæíî èìåòü ïàñïîðò ñ 3-õëåòíåé ïðîïèñêîé.")
			wait(6000)
			sampSendChat("/news Ìåä.êàðòó è êîíå÷íî æå õîðîøåå íàñòðîåíèå è æåëàíèå îáùàòüñÿ ñ ñîòðóäíèêàìè.")
			wait(6000)
			sampSendChat("/news Ïðèãëàøàåì âàñ â ÑÌÈ ã.Ëàñ-Âåíòóðàñ, æä¸ì âàñ â õîëëå ðàäèîöåíòðà!")
			wait(6000)
			sampSendChat("/news °°°° Ìóçûêàëüíàÿ çàñòàâêà Ðàäèîöåíòðà ã.Ëàñ-Âåíòóðàñ °°°°")
			wait(6000)
		end)
	end
	if imgui.Button(u8'Ýôèð â ËÂÌÖ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news °°°° Ìóçûêàëüíàÿ çàñòàâêà Ðàäèîöåíòðà ã.Ëàñ-Âåíòóðàñ °°°°")
			wait(6000)
			sampSendChat("/news Äîáðîãî âðåìåíè ñóòîê, óâàæàåìûå ðàäèîñëóøàòåëè.")
			wait(6000)
			sampSendChat("/news Âñåãäà õîòåëè ïîïðîáîâàòü ñåáÿ â ðîëè äîáðîãî äîêòîðà Àéáîëèòà? Èëè æå...")
			wait(6000)
			sampSendChat("/news ...õîòåëè ïîìîãàòü òÿæåëî ðàíåííûì ãðàæäàíàì ïîëó÷èòü 2 æèçíü")
			wait(6000)
			sampSendChat("/news Òîãäà èìåííî äëÿ âàñ ñåé÷àñ ïðîõîäèò ñîáåñåäîâàíèå â áîëüíèöó ã.Ëàñ-Âåíòóðàñ")
			wait(6000)
			sampSendChat("/news Âàñ æäåò: áîëüøàÿ çàðïëàòà, åæåäíåâíûå ïðåìèè è äîáðîñîâåñòíûé êîëëåêòèâ.")
			wait(6000)
			sampSendChat("/news ×òîáû ïðîéòè ñîáåñåäîâàíèå âàì íóæíî ïðîæèâàòü 3 ãîäà â øòàòå...")
			wait(6000)
			sampSendChat("/news ... è èìåòü ïðè ñåáå ïàñïîðò,ìåä êàðòó è ïàêåò ëèöåíçèé è áûòü çàêîíîïîñëóøíûì.")
			wait(6000)
			sampSendChat("/news Ñîáåñåäîâàíèå ïðîõîäèò â õîëëå áîëüíèöû ãîðîäà Ëàñ-Âåíòóðàñ.")
			wait(6000)
			sampSendChat("/news °°°° Ìóçûêàëüíàÿ çàñòàâêà Ðàäèîöåíòðà ã.Ëàñ-Âåíòóðàñ °°°°")
			wait(6000)
		end)
	end
	imgui.EndChild()


    imgui.SetCursorPos(imgui.ImVec2(0, 580))
    if imgui.Button(u8"Ïåðåçàïóñòèòü ñêðèïò", imgui.ImVec2(145,58)) then
        thisScript():reload()
    end
    imgui.End()
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(600)
        imgui.TextUnformatted(description)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end
