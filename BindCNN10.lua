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

local idn, itext = -1, ''

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

    sampAddChatMessage("Ѕиндер дл€ CNN", main_color)

    sampRegisterChatCommand("bmenu", cmd_bmenu)
    sampRegisterChatCommand("invv", invv)
    sampRegisterChatCommand("clearchat", clearchat)
    sampRegisterChatCommand("vig", cmd_vig)


    imgui.Process = false

    imgui.SwitchContext()
    themes.SwitchColorThemes()

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("≈сть обновление! ¬ерси€: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("—крипт успешно обновлен/откачен!", -1)
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
        sampSendChat("«дравствуйте, вы пришли к нам на собеседование?")
		wait(2000)
		sampAddChatMessage("ƒл€ продолжени€ нажмите -1; ƒл€ отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("”спешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
    	sampSendChat("’орошо, покажите ваши документы, а именно: паспорт, мед.карту и лицензии")
		wait(2000)
		sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
		wait(2000)
		sampAddChatMessage("ƒл€ продолжени€ нажмите -1; ƒл€ отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("”спешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("/me аккуратным движением руки вз€л документы у человека напротив")
		wait(2000)
		sampSendChat("/todo “ак, хорошо, это есть...*осмотрев документы")
		wait(2000)
		sampSendChat("/me аккуратным движением руки вернул документы человеку напротив")
		wait(2000)
		sampAddChatMessage("ѕодходит - 1; Ќе подходит - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampSendChat("  сожалению, ¬ы нам не подходите.")
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("ќтлично. ¬ы нам подходите. —ейчас € выдам ¬ам форму и ключ от шкафчика")
		wait(2000)
		sampSendChat("/me плавно наклонилс€ в сторону €щика от стойки и приоткрыв его...")
		wait(2000)
		sampSendChat("/me ...вз€л форму и ключ номер " ..idpl)
		wait(2000)
		sampSendChat("”дачной ¬ам работы!")
        end

    if not women.v == false then
        sampSendChat("«дравствуйте, вы пришли к нам на собеседование?")
		wait(2000)
		sampAddChatMessage("ƒл€ продолжени€ нажмите -1; ƒл€ отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("”спешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
    	sampSendChat("’орошо, покажите ваши документы, а именно: паспорт, мед.карту и лицензии")
		wait(2000)
		sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
		wait(2000)
		sampAddChatMessage("ƒл€ продолжени€ нажмите -1; ƒл€ отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("”спешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("/me аккуратным движением руки вз€ла документы у человека напротив")
		wait(2000)
		sampSendChat("/todo “ак, хорошо, это есть...*осмотрев документы")
		wait(2000)
		sampSendChat("/me аккуратным движением руки вернула документы человеку напротив")
		wait(2000)
		sampAddChatMessage("ѕодходит - 1; Ќе подходит - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampSendChat("  сожалению, ¬ы нам не подходите.")
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("ќтлично. ¬ы нам подходите. —ейчас € выдам ¬ам форму и ключ от шкафчика")
		wait(2000)
		sampSendChat("/me плавно наклонилась в сторону €щика от стойки и приоткрыв его...")
		wait(2000)
		sampSendChat("/me ...вз€ла форму и ключ номер " ..idpl)
		wait(2000)
		sampSendChat("”дачной ¬ам работы!")
    end
    end)
end

function cmd_vig(arg)
	    local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me вз€л из кармана планшет и зашел в базу данных сотрудников...")
        wait(2000)
        sampSendChat("/me ...после чего изменил информацию о сотруднике, вписал 'выговор'")
        wait(2000)
        sampShowDialog(1000, "—истема выдачи выговоров", "¬ведите id игрока и причину\n19,Ќарушение устава", "¬ыдать",'ќтмена', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/fwarn "..idn..' '..itext)
        else
            print('“ест')
        end
    end)
end

function imgui.OnDrawFrame()

    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.SetNextWindowSize(imgui.ImVec2(620, 650), imgui.Cond.FirstUseEver)
    imgui.Begin(u8"BindCNN", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	imgui.TextColored(imgui.ImVec4(0, 1, 0, 1), u8'¬ерси€: ' .. updateIni.info.vers_text)
        -- ќсновное
    imgui.BeginChild('##1', imgui.ImVec2(200, 175), true)
        imgui.Text(u8"¬аш ник: " ..nick.. "[" ..id.. "]")
        imgui.Checkbox(u8"∆енские отыгровки", women)
		imgui.SameLine()
		imgui.TextQuestion("( ? )",u8"ѕри активации отыгровки будут женскими")
    imgui.EndChild()
    
        -- “емы
    imgui.SetCursorPos(imgui.ImVec2(210, 43))
    imgui.BeginChild('##2', imgui.ImVec2(200, 175), true)
        for i, value in ipairs(themes.colorThemes) do
            if imgui.RadioButton(value, checked_radio, i) then
                themes.SwitchColorThemes(i)
            end
        end
    imgui.EndChild()
        --  оманды
    imgui.SetCursorPos(imgui.ImVec2(5, 220))
    imgui.BeginChild('##3', imgui.ImVec2(200, 175), true)
    imgui.Text(u8"/bmenu - меню скрипта\n/invv - прин€тие игрока\n/clearchat - очистить чат\n/vig - выдать выговор(в разработке)\nRalph лох")
    imgui.EndChild()
		-- ѕоказ чего либо
	imgui.SetCursorPos(imgui.ImVec2(415, 220))
    imgui.BeginChild('##6', imgui.ImVec2(200, 175), true)
    if imgui.Button(u8'—татистика игрока', imgui.ImVec2(150, 30)) then
		sampSendChat("/stats")
	end
	if imgui.Button(u8'—татистика работы', imgui.ImVec2(150, 30)) then
		sampSendChat("/jobprogress")
	end
	if imgui.Button(u8'ѕаспорт', imgui.ImVec2(150, 30)) then
		sampSendChat("/showpass " ..id)
	end
    imgui.EndChild()
        -- Ћекции
    imgui.SetCursorPos(imgui.ImVec2(415, 43))
    imgui.BeginChild('##4', imgui.ImVec2(200, 175), true)
        if imgui.Button(u8'Ћекци€ 1 - —пец.–аци€', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("/r «дравствуйте, дорогие коллеги!")
				wait(2000)
				sampSendChat("/r —ейчас € хочу вам рассказать о нашей '—пец рации ƒискорд'.")
				wait(2000)
				sampSendChat("/r ƒанна€ спец. раци€ нужна нужна абсолютно всем сотрудникам, включа€ и стажЄров.")
				wait(2000)
				sampSendChat("/r ќна предназначена дл€ быстрой передачи информации между сотрудниками")
				wait(2000)
				sampSendChat("/r “ак-же подключить еЄ очень просто")
				wait(2000)
				sampSendChat("/rb ¬се очень просто! ƒл€ тех у кого нету - https://discord.gg/brainburg")
				wait(2000)
				sampSendChat("/rb ƒелаем ник по форме [CNN LS][1] Nick_Name")
				wait(2000)
				sampSendChat("/rb пишем в канал #запрос-роли и нажимаем кнопку '«апросить роль организации'")
				wait(2000)
				sampSendChat("/rb после того как вам выдадут роль листаем ниже и подключаемс€ в канал —ћ» | LVFM")
				wait(2000)
            end)
        end
        if imgui.Button(u8'Ћекци€ 2 - —убординаци€', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("«дравствуйте, дорогие коллеги!")
				wait(2000)
				sampSendChat("—ейчас € проведу лекцию на тему '—убординаци€'.")
				wait(2000)
				sampSendChat("—убординаци€ - это правило общени€ между людьми")
				wait(2000)
				sampSendChat("¬ нашем радиоцентре общение строго на ¬ы!")
				wait(2000)
				sampSendChat("¬ы об€заны с общатьс€ с посетител€ми радиоцентрами уважительно.")
				wait(2000)
				sampSendChat("— коллегами вы так же об€заны относитьс€ на ¬ы")
				wait(2000)
				sampSendChat("Ќа этом лекци€ на тему '—убординаци€' окончена")
				wait(2000)
            end)
        end
        if imgui.Button(u8'Ћекци€ 3 - ѕ.–.ќ', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("«дравствуйте, дорогие коллеги!")
				wait(2000)
				sampSendChat("—ейчас € вам проведу лекцию на тему 'ѕ.–.ќ'")
				wait(2000)
				sampSendChat("'ѕ.–.ќ' - ѕравило –едактировани€ ќбъ€влений.")
				wait(2000)
				sampSendChat(" аждый сотрудник нашего радиоцентра об€зан знать...")
				wait(2000)
				sampSendChat("...что такое ѕ.–.ќ, и где его примен€ть.")
				wait(2000)
				sampSendChat("¬ случае если сотрудник не знает ѕ.–.ќ, на него будут наложены санкции...")
				wait(2000)
				sampSendChat(".. такие как: устное предупреждение, выговор, понижение, увольнение.")
				wait(2000)
				sampSendChat("Ѕолее подробно с этими правилами вы можете ознакомитьс€ через офф.портал штата.")
				wait(2000)
				sampSendChat("/b ѕуть к этим правилам-> forum.arizona-rp.com")
				wait(2000)
				sampSendChat("/b ‘орум -> —ервер є5 [ Brainburg ] -> √ос.структуры")
				wait(2000)
				sampSendChat("/b -> Mass Media | —редства ћассовой »нформации -> ѕравила –едактировани€ ќбъ€влений")
				wait(2000)
            end)
        end
        if imgui.Button(u8'Ћекци€ 4 - √азета', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("”важаемые коллеги, минуточку внимани€, сейчас € проведу вам лекцию на тему '√азета'")
				wait(2000)
				sampSendChat("√азета - письменное содержание происход€щего. ¬ газете может быть люба€ тема...")
				wait(2000)
				sampSendChat("... будь то рассказ о транспорте, сводка о работе, реклама чего либо, а так же информаци€ о погоде.")
				wait(2000)
				sampSendChat("ƒл€ того что-бы делать газеты нужно иметь желание, а так же принтер!")
				wait(2000)
				sampSendChat("/b Ќам понадобитс€ фотошоп!")
				wait(2000)
				sampSendChat("ƒл€ любой газеты необходима бумага!")
				wait(2000)
				sampSendChat("/b ‘он газеты можете запросить у лидера своей организации.")
				wait(2000)
				sampSendChat("ƒл€ удобства выпуска газеты, вы можете делать фоторепортажи.")
				wait(2000)
				sampSendChat("/b ƒелаете скриншот чего либо, и вставл€ете в шаблон газеты.")
				wait(2000)
				sampSendChat("ƒл€ вашего удобства у нас есть карандаши.")
				wait(2000)
				sampSendChat("/b ѕосле загрузки всех фотографий, на шаблоне пишете сценарий газеты.")
				wait(2000)
				sampSendChat("ѕосле того как вы все сделали, вы можете воспользоватьс€ принтером и распечатать парочку газет.")
				wait(2000)
				sampSendChat("/b —охран€ем полученное действие.")
				wait(2000)
				sampSendChat("Ћекци€ на тему '√азета' окончена.")
				wait(2000)
            end)
        end
        if imgui.Button(u8'¬ыдача листовок', imgui.ImVec2(150, 30)) then
            lua_thread.create(function ()
                sampSendChat("/do —умка на плече.")
				wait(2000)
				sampSendChat("/me движением руки повернул сумку к себе")
				wait(2000)
				sampSendChat("/do ¬згл€д на сумке.")
				wait(2000)
				sampSendChat("/me правой рукой пот€нул за замок сумки")
				wait(2000)
				sampSendChat("/do —умка открыта.")
				wait(2000)
				sampSendChat("/do ¬ сумке приглашение в –адиоцентр г.Ћас-¬ентура")
				wait(2000)
				sampSendChat("/todo ¬от держите*передава€ листовку человеку на против")
				wait(2000)
				sampSendChat("/do ¬ листовке написано")
				wait(2000)
				sampSendChat("/do Ѕольша€ зарплата, весела€ робота, веселые сотрудники")
				wait(2000)
				sampSendChat("/do —обеседование в ’олле –адиоцентре.")
				wait(2000)
            end)
        end
    imgui.EndChild()
		--Ќовостные эфиры
	imgui.SetCursorPos(imgui.ImVec2(210, 220))
	imgui.BeginChild('##5', imgui.ImVec2(200, 175), true)
	if imgui.Button(u8'–еклама —ћ» Ћ¬', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток уважаемые жители штата.")
			wait(6000)
			sampSendChat("/news ћы приглашаем вас на собеседование в –адиоцентр —ћ» г.Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news “ак же, мы выдаЄм лучшим сотрудникам дн€ ежедневные премии от 200.000$")
			wait(6000)
			sampSendChat("/news ƒобрый и отзычивой колектив который всЄгда будет вам помогать.")
			wait(6000)
			sampSendChat("/news  огда много роботников у нас тогда часто проход€т меропри€ти€ с призами")
			wait(6000)
			sampSendChat("/news «десь вы сможете чуствовать себ€ важной личностью.")
			wait(6000)
			sampSendChat("/news ј также при достижении '–Єпортер' вы сможете проводить эфиры.")
			wait(6000)
			sampSendChat("/news Ќа которых сможете зароботать от 1.000.000$ до 5.000.000$")
			wait(6000)
			sampSendChat("/news „ем быстрее вы к нам устроитесь тем быстрее начнЄте жить в удовольствие.")
			wait(6000)
			sampSendChat("/news „тобы устроитс€ к нам на работу вам нужно иметь паспорт с 3-хлетней пропиской")
			wait(6000)
			sampSendChat("/news ћед.карту и конечно же хорошее настроение и желание общатьс€ с сотрудниками.")
			wait(6000)
			sampSendChat("/news ѕриглашаем вас в —ћ» г.Ћас-¬ентурас, ждЄм вас в холле радиоцентра!")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама Ћ—ћ÷', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news ¬сегда хотели попробовать себ€ в роли доброго доктора јйболита? »ли же...")
			wait(6000)
			sampSendChat("/news ...хотели помогать т€жело раненным гражданам получить 2 жизнь")
			wait(6000)
			sampSendChat("/news “огда именно дл€ вас сейчас проходит собеседование в больницу г.Ћос-—антос")
			wait(6000)
			sampSendChat("/news ¬ас ждет: больша€ зарплата, ежедневные премии и добросовестный коллектив.")
			wait(6000)
			sampSendChat("/news „тобы пройти собеседование вам нужно проживать 3 года в штате...")
			wait(6000)
			sampSendChat("/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле больницы города Ћос-—антос.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама Ћ¬ћ÷', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news ¬сегда хотели попробовать себ€ в роли доброго доктора јйболита? »ли же...")
			wait(6000)
			sampSendChat("/news ...хотели помогать т€жело раненным гражданам получить 2 жизнь")
			wait(6000)
			sampSendChat("/news “огда именно дл€ вас сейчас проходит собеседование в больницу г.Ћас-¬ентурасс")
			wait(6000)
			sampSendChat("/news ¬ас ждет: больша€ зарплата, ежедневные премии и добросовестный коллектив.")
			wait(6000)
			sampSendChat("/news „тобы пройти собеседование вам нужно проживать 3 года в штате...")
			wait(6000)
			sampSendChat("/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле больницы города Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама —‘ћ÷', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news ¬сегда хотели попробовать себ€ в роли доброго доктора јйболита? »ли же...")
			wait(6000)
			sampSendChat("/news ...хотели помогать т€жело раненным гражданам получить 2 жизнь")
			wait(6000)
			sampSendChat("/news “огда именно дл€ вас сейчас проходит собеседование в больницу г.—ан-‘иерро")
			wait(6000)
			sampSendChat("/news ¬ас ждет: больша€ зарплата, ежедневные премии и добросовестный коллектив.")
			wait(6000)
			sampSendChat("/news „тобы пройти собеседование вам нужно проживать 3 года в штате...")
			wait(6000)
			sampSendChat("/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле больницы города —ан-‘иерро.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама ÷Ћ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒобрый день штат, говорит радиоцентр г.Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news ¬аша мечта обучать людей? Ќравитс€ давать люд€м новые знани€?")
			wait(6000)
			sampSendChat("/news “огда сейчас ваш шанс! —ейчас проходит собеседование в ÷ентр лицензировани€!")
			wait(6000)
			sampSendChat("/news ¬ас ждет добрый и позитивный коллектив и добросовестное начальство!")
			wait(6000)
			sampSendChat("/news  ритерии: прописка от 3-х лет,иметь паспорт и мед.карту. Ѕыть в опр€тном виде.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле офиса ÷ентра лицензировани€.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама Ћ—а', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒобрый день Ўтат, вещает радиоцентр города Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news ¬ы всегда хотели служить в лучших войсках штата?")
			wait(6000)
			sampSendChat("/news ’отите получить высокий чин и отдать долг Ўтату? “огда это ваш шанс!")
			wait(6000)
			sampSendChat("/news —ейчас проходит призыв в войска города Ћос-—антос.")
			wait(6000)
			sampSendChat("/news ѕри себе иметь пакет документов,паспорт и мед.карту,быть в опр€тном виде.")
			wait(6000)
			sampSendChat("/news ѕризыв проходит в военкомате города Ћос-—антос.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама “—–', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ¬ы всегда мечтали защищать Ўтат от преступников? ’отите помочь Ўтату?")
			wait(6000)
			sampSendChat("/news “огда именно сейчас и именно дл€ ¬ас проходит собеседование в “юрьму —трогого –ежима.")
			wait(6000)
			sampSendChat("/news “олько там вас ждет хороша€ заработна€ плата...")
			wait(6000)
			sampSendChat("/news ...карьерный рост и дружный коллектив.")
			wait(6000)
			sampSendChat("/news » не забывайте ,по мимо дубинки и оружи€ вам выдадут новый комплект наручников.")
			wait(6000)
			sampSendChat("/news  ритерии: иметь полный пакет документов, проживать в штате не менее 3-х лет...")
			wait(6000)
			sampSendChat("/news ...быть законопослушным гражданином и иметь опр€тный вид.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в ¬оенкомате города Ћас-¬ентурас. Ќе упустите свой шанс")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама —‘а', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒобрый день Ўтат, вещает радиоцентр города Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news ¬ы всегда хотели служить в лучших войсках штата?")
			wait(6000)
			sampSendChat("/news ’отите получить высокий чин и отдать долг Ўтату? “огда это ваш шанс!")
			wait(6000)
			sampSendChat("/news —ейчас проходит призыв в войска города —ан-‘иерро.")
			wait(6000)
			sampSendChat("/news ѕри себе иметь пакет документов,паспорт и мед.карту,быть в опр€тном виде.")
			wait(6000)
			sampSendChat("/news ѕризыв проходит в военкомате города —ан-‘иерро.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама Ћ—ѕƒ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news —ейчас проходит собеседование в полицейский департамент г.Ћос-—антос.")
			wait(6000)
			sampSendChat("/news ¬ас ждет: больша€ зарплата, ежедневные премии и добросовестный коллектив.")
			wait(6000)
			sampSendChat("/news „тобы пройти собеседование вам нужно иметь при себе...")
			wait(6000)
			sampSendChat("/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле полицейского участка г.Ћос-—антос.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама Ћ¬ѕƒ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news —ейчас проходит собеседование в полицейский департамент г.Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news ¬ас ждет: больша€ зарплата, ежедневные премии и добросовестный коллектив.")
			wait(6000)
			sampSendChat("/news „тобы пройти собеседование вам нужно иметь при себе...")
			wait(6000)
			sampSendChat("/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле полицейского участка г.Ћас-¬ентурас.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама —‘ѕƒ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news —ейчас проходит собеседование в полицейский департамент г.—ан-‘иерро")
			wait(6000)
			sampSendChat("/news ¬ас ждет: больша€ зарплата, ежедневные премии и добросовестный коллектив.")
			wait(6000)
			sampSendChat("/news „тобы пройти собеседование вам нужно иметь при себе...")
			wait(6000)
			sampSendChat("/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле полицейского участка г.—ан-‘иерро.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама ѕрав-во', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news ¬ы всегда хотели работать с бумагами? Ѕыть приближенным к губернатору?")
			wait(6000)
			sampSendChat("/news “огда именно дл€ вас проходит собеседование в ћэрию города Ћос —антос.")
			wait(6000)
			sampSendChat("/news ќтличный карьерный рост,больша€ зарплата,дружелюбный коллектив.")
			wait(6000)
			sampSendChat("/news  ритерии: иметь пакет документов,паспорт и мед.карту,быть в опр€тном виде.")
			wait(6000)
			sampSendChat("/news “акже быть законопослушным гражданином.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле ћэрии города г.Ћос-—антос.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама ÷Ѕ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news ¬ы всегда хотели попробовать себ€ в банковском деле? »ли же...")
			wait(6000)
			sampSendChat("/news ...проводить кучу операций со счетами?")
			wait(6000)
			sampSendChat("/news “огда именно дл€ вас сейчас проходит собеседование в ÷ентральный банк.")
			wait(6000)
			sampSendChat("/news »менно тут, за отчеты, оставленные на портале штата даютс€ премии!")
			wait(6000)
			sampSendChat("/news  ритерии: ќт 3-х лет в штате, иметь пакет документов, а так же быть...")
			wait(6000)
			sampSendChat("/news ...законопослушным и быть опр€тно одетым..")
			wait(6000)
			sampSendChat("/news —обеседование проходит в ÷ентральном банке г.Ћос-—антос. ∆дем именно вас.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	if imgui.Button(u8'–еклама —“ ', imgui.ImVec2(150, 30)) then
		lua_thread.create(function ()
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
			sampSendChat("/news ƒоброго времени суток, уважаемые радиослушатели.")
			wait(6000)
			sampSendChat("/news ¬ы всегда хотели работать с бумагами? —траховать гражданам штата авто или недвижимость?")
			wait(6000)
			sampSendChat("/news “огда именно дл€ вас проходит собеседование в —траховую компанию г.—ан-‘иерро.")
			wait(6000)
			sampSendChat("/news ¬ас ждет: отличный карьерный рост, больша€ зарплата, дружелюбный коллектив.")
			wait(6000)
			sampSendChat("/news  ритерии: иметь пакет документов, паспорт и мед.карту, быть в опр€тном виде.")
			wait(6000)
			sampSendChat("/news “акже быть законопослушным гражданином.")
			wait(6000)
			sampSendChat("/news —обеседование проходит в холле —траховой компании г. —ан-‘иерро.")
			wait(6000)
			sampSendChat("/news Х∞Х∞Х∞Х∞Х ћузыкальна€ заставка –адиоцентра г.Ћас-¬ентурас Х∞Х∞Х∞Х∞Х")
			wait(6000)
		end)
	end
	imgui.EndChild()


    imgui.SetCursorPos(imgui.ImVec2(0, 580))
    if imgui.Button(u8"ѕерезапустить скрипт", imgui.ImVec2(145,58)) then
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
