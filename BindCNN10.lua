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

--local directIni = "moonloader\\resource\\settings.ini"
--local mainIni = inicfg.load(nil, directIni)
--local statseIni = inicfg.save(mainIni, directIni)

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

local script_vers = 1.7
local script_vers_text = "1.7"

local update_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/BindCNN10.lua"
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

    health = getCharHealth(PLAYER_PED)

    sampAddChatMessage("[BindCNN10] Биндер для CNN", main_color)
	sampAddChatMessage("[BindCNN10] Автор: Kevin McWood", main_color)
	sampAddChatMessage("[BindCNN10] Специально для сервера Brainburg", main_color)

    sampRegisterChatCommand("bmenu", cmd_bmenu)
    sampRegisterChatCommand("invv", invv)
    sampRegisterChatCommand("clearchat", clearchat)
    sampRegisterChatCommand("vig", cmd_vig)
	sampRegisterChatCommand("unvig", cmd_unvig)
	sampRegisterChatCommand("exp", cmd_exp)
	sampRegisterChatCommand("fmt", cmd_fmt)
	sampRegisterChatCommand("ufmt", cmd_unfmt)

    imgui.Process = false

    imgui.SwitchContext()
    themes.SwitchColorThemes()

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("Скрипт успешно обновлен/откачен!", -1)
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

function invv(arg)
    local _,  ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)

    lua_thread.create(function ()
    if not women.v == true then
        sampSendChat("Здравствуйте, вы пришли к нам на собеседование?")
		wait(2000)
		sampAddChatMessage("Для продолжения нажмите -1; Для отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("Успешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
    	sampSendChat("Хорошо, покажите ваши документы, а именно: паспорт, мед.карту и лицензии")
		wait(2000)
		sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
		wait(2000)
		sampAddChatMessage("Для продолжения нажмите -1; Для отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("Успешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("/me аккуратным движением руки взял документы у человека напротив")
		wait(2000)
		sampSendChat("/todo Так, хорошо, это есть...*осмотрев документы")
		wait(2000)
		sampSendChat("/me аккуратным движением руки вернул документы человеку напротив")
		wait(2000)
		sampAddChatMessage("Подходит - 1; Не подходит - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampSendChat("К сожалению, Вы нам не подходите.")
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("Отлично. Вы нам подходите. Сейчас я выдам Вам форму и ключ от шкафчика")
		wait(2000)
		sampSendChat("/me плавно наклонился в сторону ящика от стойки и приоткрыв его...")
		wait(2000)
		sampSendChat("/me ...взял форму и ключ номер " ..idpl)
		wait(2000)
		sampSendChat("/invite " ..idpl)
		wait(2000)
		sampSendChat("Удачной Вам работы!")
        end

    if not women.v == false then
        sampSendChat("Здравствуйте, вы пришли к нам на собеседование?")
		wait(2000)
		sampAddChatMessage("Для продолжения нажмите -1; Для отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("Успешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
    	sampSendChat("Хорошо, покажите ваши документы, а именно: паспорт, мед.карту и лицензии")
		wait(2000)
		sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
		wait(2000)
		sampAddChatMessage("Для продолжения нажмите -1; Для отметы нажмите - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("Успешно отменено", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("/me аккуратным движением руки взяла документы у человека напротив")
		wait(2000)
		sampSendChat("/todo Так, хорошо, это есть...*осмотрев документы")
		wait(2000)
		sampSendChat("/me аккуратным движением руки вернула документы человеку напротив")
		wait(2000)
		sampAddChatMessage("Подходит - 1; Не подходит - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampSendChat("К сожалению, Вы нам не подходите.")
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("Отлично. Вы нам подходите. Сейчас я выдам Вам форму и ключ от шкафчика")
		wait(2000)
		sampSendChat("/me плавно наклонилась в сторону ящика от стойки и приоткрыв его...")
		wait(2000)
		sampSendChat("/me ...взяла форму и ключ номер " ..idpl)
		wait(2000)
		sampSendChat("/invite " ..idpl)
		wait(2000)
		sampSendChat("Удачной Вам работы!")
    end
    end)
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

function cmd_vig(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me взял из кармана планшет и зашел в базу данных сотрудников...")
        wait(2000)
        sampSendChat("/me ...после чего изменил информацию о сотруднике, вписал 'выговор'")
        wait(2000)
        sampShowDialog(1000, "Система выдачи выговоров", "Введите id игрока и причину\n19,Нарушение устава", "Выдать",'Отмена', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/fwarn "..idn..' '..itext)
        else
            print('Тест')
        end
    end)
end

function cmd_unvig(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
	local _, idpl = sampGetPlayerIdByCharHandle(ped)
	lua_thread.create(function ()
		sampSendChat("/me взял из кармана планшет и зашел в базу данных сотрудников...")
		wait(2000)
		sampSendChat("/me ...после чего изменил информацию о сотруднике, снял выговор")
		wait(2000)
		sampShowDialog(1000, "Система выдачи выговоров", "Введите id игрока", "Выдать",'Отмена', 1)
		while sampIsDialogActive(6406) do wait(100) end
		local result, button, list, input = sampHasDialogRespond(6406)
		if input:find('(%d+)') and button == 1 then
			idn = input:match('(%d+)')
			sampSendChat("/unfwarn "..idn)
		else
			print('Тест')
		end
	end)
end

function cmd_exp(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me взял человека за шкирку и повел ко входу")
        wait(2000)
        sampSendChat("/todo В следующий раз будете вести себя лучше*выкидывая человека из радиоцентра")
        wait(2000)
        sampShowDialog(1000, "Система выпровода игрока", "Введите id игрока и причину\n19,Нарушение порядка", "Выдгнать",'Отмена', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/expel "..idn..' '..itext)
        else
            print('Тест')
        end
    end)
end

function cmd_fmt(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me взял из кармана планшет и зашел в базу данных сотрудников...")
        wait(2000)
        sampSendChat("/me ...после чего изменил информацию о сотруднике, и заблокировал доступ к рации")
        wait(2000)
        sampShowDialog(1000, "Система выдачи мута", "Введите id игрока и причину\n19,Нарушение устава", "Выдать",'Отмена', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/fmute "..idn..' '..itext)
        else
            print('Тест')
        end
    end)
end

function cmd_unfmt(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me взял из кармана планшет и зашел в базу данных сотрудников...")
        wait(2000)
        sampSendChat("/me ...после чего изменил информацию о сотруднике, и разблокировал доступ к рации")
        wait(2000)
        sampShowDialog(1000, "Система выдачи мута", "Введите id игрока и причину\n19,Нарушение устава", "Выдать",'Отмена', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+)') and button == 1 then
            idn, itext = input:match('(%d+)')
            sampSendChat("/unfmute "..idn)
        else
            print('Тест')
        end
    end)
end

function imgui.OnDrawFrame()

	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(620, 650), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"BindCNN", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	imgui.TextColored(imgui.ImVec4(0, 1, 0, 1), u8'Версия: ' .. updateIni.info.vers_text)
	-- Основное
	imgui.BeginChild('##Основное', imgui.ImVec2(200, 175), true)
    imgui.Text(u8"Ваш ник: " ..nick.. "[" ..id.. "]")
    imgui.Checkbox(u8"Женские отыгровки", women)
	imgui.SameLine()
	imgui.TextQuestion("( ? )",u8"При активации отыгровки будут женскими")
	imgui.EndChild()
	-- Темы
	imgui.SetCursorPos(imgui.ImVec2(210, 43))
	imgui.BeginChild('##Темы', imgui.ImVec2(200, 175), true)
    	for i, value in ipairs(themes.colorThemes) do
        	if imgui.RadioButton(value, checked_radio, i) then
            themes.SwitchColorThemes(i)
        	end
    	end
	imgui.EndChild()
	-- Лекции
	imgui.SetCursorPos(imgui.ImVec2(415, 43))
	imgui.BeginChild('##Лекции', imgui.ImVec2(200, 175), true)
    	if imgui.Button(u8'Лекция 1 - Спец.Рация', imgui.ImVec2(150, 30)) then
        	lua_thread.create(function ()
            	sampSendChat("/r Здравствуйте, дорогие коллеги!")
				wait(2000)
				sampSendChat("/r Сейчас я хочу вам рассказать о нашей 'Спец рации Дискорд'.")
				wait(2000)
				sampSendChat("/r Данная спец. рация нужна нужна абсолютно всем сотрудникам, включая и стажёров.")
				wait(2000)
				sampSendChat("/r Она предназначена для быстрой передачи информации между сотрудниками")
				wait(2000)
				sampSendChat("/r Так-же подключить её очень просто")
				wait(2000)
				sampSendChat("/rb Все очень просто! Для тех у кого нету - https://discord.gg/brainburg")
				wait(2000)
				sampSendChat("/rb Делаем ник по форме [CNN LS][1] Nick_Name")
				wait(2000)
				sampSendChat("/rb пишем в канал #запрос-роли и нажимаем кнопку 'Запросить роль организации'")
				wait(2000)
				sampSendChat("/rb после того как вам выдадут роль листаем ниже и подключаемся в канал СМИ | LVFM")
				wait(2000)
			end)
	    end
		if imgui.Button(u8'Лекция 2 - Субординация', imgui.ImVec2(150, 30)) then
	        lua_thread.create(function ()
    	        sampSendChat("Здравствуйте, дорогие коллеги!")
				wait(2000)
				sampSendChat("Сейчас я проведу лекцию на тему 'Субординация'.")
				wait(2000)				
				sampSendChat("Субординация - это правило общения между людьми")
				wait(2000)
				sampSendChat("В нашем радиоцентре общение строго на Вы!")
				wait(2000)
				sampSendChat("Вы обязаны с общаться с посетителями радиоцентрами уважительно.")
				wait(2000)
				sampSendChat("С коллегами вы так же обязаны относиться на Вы")
				wait(2000)
				sampSendChat("На этом лекция на тему 'Субординация' окончена")
				wait(2000)
        	end)
    	end
    	if imgui.Button(u8'Лекция 3 - П.Р.О', imgui.ImVec2(150, 30)) then
        	lua_thread.create(function ()
        		sampSendChat("Здравствуйте, дорогие коллеги!")
				wait(2000)
				sampSendChat("Сейчас я вам проведу лекцию на тему 'П.Р.О'")
				wait(2000)
				sampSendChat("'П.Р.О' - Правило Редактирования Объявлений.")
				wait(2000)
				sampSendChat("Каждый сотрудник нашего радиоцентра обязан знать...")
				wait(2000)
				sampSendChat("...что такое П.Р.О, и где его применять.")
				wait(2000)
				sampSendChat("В случае если сотрудник не знает П.Р.О, на него будут наложены санкции...")
				wait(2000)
				sampSendChat(".. такие как: устное предупреждение, выговор, понижение, увольнение.")
				wait(2000)
				sampSendChat("Более подробно с этими правилами вы можете ознакомиться через офф.портал штата.")
				wait(2000)
				sampSendChat("/b Путь к этим правилам-> forum.arizona-rp.com")
				wait(2000)
				sampSendChat("/b Форум -> Сервер №5 [ Brainburg ] -> Гос.структуры")
				wait(2000)
				sampSendChat("/b -> Mass Media | Средства Массовой Информации -> Правила Редактирования Объявлений")
				wait(2000)
        	end)
    	end
    	if imgui.Button(u8'Лекция 4 - Газета', imgui.ImVec2(150, 30)) then
        	lua_thread.create(function ()
            	sampSendChat("Уважаемые коллеги, минуточку внимания, сейчас я проведу вам лекцию на тему 'Газета'")
				wait(2000)
				sampSendChat("Газета - письменное содержание происходящего. В газете может быть любая тема...")
				wait(2000)
				sampSendChat("... будь то рассказ о транспорте, сводка о работе, реклама чего либо, а так же информация о погоде.")
				wait(2000)
				sampSendChat("Для того что-бы делать газеты нужно иметь желание, а так же принтер!")
				wait(2000)
				sampSendChat("/b Нам понадобится фотошоп!")
				wait(2000)
				sampSendChat("Для любой газеты необходима бумага!")
				wait(2000)
				sampSendChat("/b Фон газеты можете запросить у лидера своей организации.")
				wait(2000)
				sampSendChat("Для удобства выпуска газеты, вы можете делать фоторепортажи.")
				wait(2000)
				sampSendChat("/b Делаете скриншот чего либо, и вставляете в шаблон газеты.")
				wait(2000)
				sampSendChat("Для вашего удобства у нас есть карандаши.")
				wait(2000)
				sampSendChat("/b После загрузки всех фотографий, на шаблоне пишете сценарий газеты.")
				wait(2000)
				sampSendChat("После того как вы все сделали, вы можете воспользоваться принтером и распечатать парочку газет.")
				wait(2000)
				sampSendChat("/b Сохраняем полученное действие.")
				wait(2000)
				sampSendChat("Лекция на тему 'Газета' окончена.")
				wait(2000)
    	    end)
    	end
    	if imgui.Button(u8'Выдача листовок', imgui.ImVec2(150, 30)) then
        	lua_thread.create(function ()
            	sampSendChat("/do Сумка на плече.")
				wait(2000)
				sampSendChat("/me движением руки повернул сумку к себе")
				wait(2000)
				sampSendChat("/do Взгляд на сумке.")
				wait(2000)
				sampSendChat("/me правой рукой потянул за замок сумки")
				wait(2000)
				sampSendChat("/do Сумка открыта.")
				wait(2000)
				sampSendChat("/do В сумке приглашение в Радиоцентр г.Лас-Вентура")
				wait(2000)
				sampSendChat("/todo Вот держите*передавая листовку человеку на против")
				wait(2000)
				sampSendChat("/do В листовке написано")
				wait(2000)
				sampSendChat("/do Большая зарплата, веселая робота, веселые сотрудники")
				wait(2000)
				sampSendChat("/do Собеседование в Холле Радиоцентре.")
				wait(2000)
     	   	end)
    	end
	imgui.EndChild()
	-- Показ чего либо
	imgui.SetCursorPos(imgui.ImVec2(415, 220))
	imgui.BeginChild('##Показ', imgui.ImVec2(200, 175), true)
    	if imgui.Button(u8'Статистика игрока', imgui.ImVec2(150, 30)) then
			sampSendChat("/stats")
		end
		if imgui.Button(u8'Статистика работы', imgui.ImVec2(150, 30)) then
			sampSendChat("/jobprogress")
		end
		if imgui.Button(u8'Паспорт', imgui.ImVec2(150, 30)) then
			sampSendChat("/showpass " ..id)
		end
		if imgui.Button(u8'Лицензии', imgui.ImVec2(150, 30)) then
			sampSendChat("/showlic " ..id)
		end
	imgui.EndChild()
 	-- Команды
 	imgui.SetCursorPos(imgui.ImVec2(5, 220))
 	imgui.BeginChild('##Команды', imgui.ImVec2(200, 175), true)
		imgui.Text(u8"/bmenu - меню скрипта\n/invv - принятие игрока\n/clearchat - очистить чат\n/vig - выдать выговор\n/unvig - снять выговор\n/exp - выгнать человека\n/fmt - выдать мут\n/unfmt - снять мут")
 	imgui.EndChild()
	--Новостные эфиры
	imgui.SetCursorPos(imgui.ImVec2(210, 220))
	imgui.BeginChild('##Эфиры', imgui.ImVec2(200, 175), true)
		if imgui.Button(u8'/gov - СМИ ЛВ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
			sampSendChat("/gov [CNN LV] Уважаемые жители штата, прошу минуточку внимания..")
			wait(6000)
			sampSendChat("/gov [CNN LV] В холле Радиостанции г.Лас-Вентурас проходит собеседование.")
			wait(6000)
			sampSendChat("/gov [CNN LV] Ждём всех желающих. При себе иметь: паспорт, мед.карту, пакет лицензий.")
			wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама СМИ ЛВ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток уважаемые жители штата.")
				wait(6000)
				sampSendChat("/news Мы приглашаем вас на собеседование в Радиоцентр СМИ г.Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news Так же, мы выдаём лучшим сотрудникам дня ежедневные премии от 200.000$")
				wait(6000)
				sampSendChat("/news Добрый и отзычивой колектив который всёгда будет вам помогать.")
				wait(6000)
				sampSendChat("/news Когда много роботников у нас тогда часто проходят мероприятия с призами")
				wait(6000)
				sampSendChat("/news Здесь вы сможете чуствовать себя важной личностью.")
				wait(6000)
				sampSendChat("/news А также при достижении 'Рёпортер' вы сможете проводить эфиры.")
				wait(6000)
				sampSendChat("/news На которых сможете зароботать от 1.000.000$ до 5.000.000$")
				wait(6000)
				sampSendChat("/news Чем быстрее вы к нам устроитесь тем быстрее начнёте жить в удовольствие.")
				wait(6000)
				sampSendChat("/news Чтобы устроится к нам на работу вам нужно иметь паспорт с 3-хлетней пропиской")
				wait(6000)
				sampSendChat("/news Мед.карту и конечно же хорошее настроение и желание общаться с сотрудниками.")
				wait(6000)
				sampSendChat("/news Приглашаем вас в СМИ г.Лас-Вентурас, ждём вас в холле радиоцентра!")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЛСМЦ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Всегда хотели попробовать себя в роли доброго доктора Айболита? Или же...")
				wait(6000)
				sampSendChat("/news ...хотели помогать тяжело раненным гражданам получить 2 жизнь")
				wait(6000)
				sampSendChat("/news Тогда именно для вас сейчас проходит собеседование в больницу г.Лос-Сантос")
				wait(6000)
				sampSendChat("/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.")
				wait(6000)
				sampSendChat("/news Чтобы пройти собеседование вам нужно проживать 3 года в штате...")
				wait(6000)
				sampSendChat("/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле больницы города Лос-Сантос.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЛВМЦ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Всегда хотели попробовать себя в роли доброго доктора Айболита? Или же...")
				wait(6000)
				sampSendChat("/news ...хотели помогать тяжело раненным гражданам получить 2 жизнь")
				wait(6000)
				sampSendChat("/news Тогда именно для вас сейчас проходит собеседование в больницу г.Лас-Вентурасс")
				wait(6000)
				sampSendChat("/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.")
				wait(6000)
				sampSendChat("/news Чтобы пройти собеседование вам нужно проживать 3 года в штате...")
				wait(6000)
				sampSendChat("/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле больницы города Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама СФМЦ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Всегда хотели попробовать себя в роли доброго доктора Айболита? Или же...")
				wait(6000)
				sampSendChat("/news ...хотели помогать тяжело раненным гражданам получить 2 жизнь")
				wait(6000)
				sampSendChat("/news Тогда именно для вас сейчас проходит собеседование в больницу г.Сан-Фиерро")
				wait(6000)
				sampSendChat("/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.")
				wait(6000)
				sampSendChat("/news Чтобы пройти собеседование вам нужно проживать 3 года в штате...")
				wait(6000)
				sampSendChat("/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле больницы города Сан-Фиерро.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЦЛ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Добрый день штат, говорит радиоцентр г.Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news Ваша мечта обучать людей? Нравится давать людям новые знания?")
				wait(6000)
				sampSendChat("/news Тогда сейчас ваш шанс! Сейчас проходит собеседование в Центр лицензирования!")
				wait(6000)
				sampSendChat("/news Вас ждет добрый и позитивный коллектив и добросовестное начальство!")
				wait(6000)
				sampSendChat("/news Критерии: прописка от 3-х лет,иметь паспорт и мед.карту. Быть в опрятном виде.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле офиса Центра лицензирования.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЛСа', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Добрый день Штат, вещает радиоцентр города Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news Вы всегда хотели служить в лучших войсках штата?")
				wait(6000)
				sampSendChat("/news Хотите получить высокий чин и отдать долг Штату? Тогда это ваш шанс!")
				wait(6000)
				sampSendChat("/news Сейчас проходит призыв в войска города Лос-Сантос.")
				wait(6000)
				sampSendChat("/news При себе иметь пакет документов,паспорт и мед.карту,быть в опрятном виде.")
				wait(6000)
				sampSendChat("/news Призыв проходит в военкомате города Лос-Сантос.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ТСР', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Вы всегда мечтали защищать Штат от преступников? Хотите помочь Штату?")
				wait(6000)
				sampSendChat("/news Тогда именно сейчас и именно для Вас проходит собеседование в Тюрьму Строгого Режима.")
				wait(6000)
				sampSendChat("/news Только там вас ждет хорошая заработная плата...")
				wait(6000)
				sampSendChat("/news ...карьерный рост и дружный коллектив.")
				wait(6000)
				sampSendChat("/news И не забывайте ,по мимо дубинки и оружия вам выдадут новый комплект наручников.")
				wait(6000)
				sampSendChat("/news Критерии: иметь полный пакет документов, проживать в штате не менее 3-х лет...")
				wait(6000)
				sampSendChat("/news ...быть законопослушным гражданином и иметь опрятный вид.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в Военкомате города Лас-Вентурас. Не упустите свой шанс")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)	
		end
		if imgui.Button(u8'Реклама СФа', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Добрый день Штат, вещает радиоцентр города Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news Вы всегда хотели служить в лучших войсках штата?")
				wait(6000)
				sampSendChat("/news Хотите получить высокий чин и отдать долг Штату? Тогда это ваш шанс!")
				wait(6000)
				sampSendChat("/news Сейчас проходит призыв в войска города Сан-Фиерро.")
				wait(6000)
				sampSendChat("/news При себе иметь пакет документов,паспорт и мед.карту,быть в опрятном виде.")
				wait(6000)
				sampSendChat("/news Призыв проходит в военкомате города Сан-Фиерро.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЛСПД', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Сейчас проходит собеседование в полицейский департамент г.Лос-Сантос.")
				wait(6000)
				sampSendChat("/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.")
				wait(6000)
				sampSendChat("/news Чтобы пройти собеседование вам нужно иметь при себе...")
				wait(6000)
				sampSendChat("/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле полицейского участка г.Лос-Сантос.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЛВПД', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Сейчас проходит собеседование в полицейский департамент г.Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.")
				wait(6000)
				sampSendChat("/news Чтобы пройти собеседование вам нужно иметь при себе...")
				wait(6000)
				sampSendChat("/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле полицейского участка г.Лас-Вентурас.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама СФПД', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Сейчас проходит собеседование в полицейский департамент г.Сан-Фиерро")
				wait(6000)
				sampSendChat("/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.")
				wait(6000)
				sampSendChat("/news Чтобы пройти собеседование вам нужно иметь при себе...")
				wait(6000)
				sampSendChat("/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле полицейского участка г.Сан-Фиерро.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама Прав-во', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Вы всегда хотели работать с бумагами? Быть приближенным к губернатору?")
				wait(6000)
				sampSendChat("/news Тогда именно для вас проходит собеседование в Мэрию города Лос Сантос.")
				wait(6000)
				sampSendChat("/news Отличный карьерный рост,большая зарплата,дружелюбный коллектив.")
				wait(6000)
				sampSendChat("/news Критерии: иметь пакет документов,паспорт и мед.карту,быть в опрятном виде.")
				wait(6000)
				sampSendChat("/news Также быть законопослушным гражданином.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле Мэрии города г.Лос-Сантос.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама ЦБ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Вы всегда хотели попробовать себя в банковском деле? Или же...")
				wait(6000)
				sampSendChat("/news ...проводить кучу операций со счетами?")
				wait(6000)
				sampSendChat("/news Тогда именно для вас сейчас проходит собеседование в Центральный банк.")
				wait(6000)
				sampSendChat("/news Именно тут, за отчеты, оставленные на портале штата даются премии!")
				wait(6000)
				sampSendChat("/news Критерии: От 3-х лет в штате, иметь пакет документов, а так же быть...")
				wait(6000)
				sampSendChat("/news ...законопослушным и быть опрятно одетым..")
				wait(6000)
				sampSendChat("/news Собеседование проходит в Центральном банке г.Лос-Сантос. Ждем именно вас.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
		if imgui.Button(u8'Реклама СТК', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
				sampSendChat("/news Доброго времени суток, уважаемые радиослушатели.")
				wait(6000)
				sampSendChat("/news Вы всегда хотели работать с бумагами? Страховать гражданам штата авто или недвижимость?")
				wait(6000)
				sampSendChat("/news Тогда именно для вас проходит собеседование в Страховую компанию г.Сан-Фиерро.")
				wait(6000)
				sampSendChat("/news Вас ждет: отличный карьерный рост, большая зарплата, дружелюбный коллектив.")
				wait(6000)
				sampSendChat("/news Критерии: иметь пакет документов, паспорт и мед.карту, быть в опрятном виде.")
				wait(6000)
				sampSendChat("/news Также быть законопослушным гражданином.")
				wait(6000)
				sampSendChat("/news Собеседование проходит в холле Страховой компании г. Сан-Фиерро.")
				wait(6000)
				sampSendChat("/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лас-Вентурас •°•°•°•°•")
				wait(6000)
			end)
		end
	imgui.EndChild()

    imgui.SetCursorPos(imgui.ImVec2(0, 580))
    	if imgui.Button(u8"Перезапустить скрипт", imgui.ImVec2(145,58)) then
        	thisScript():reload()
    	end
	Imgui.End()
end

-- Аннатация
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
