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

local script_vers = 5
local script_vers_text = "5.2.1"

local update_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/update.ini" 
local update_path = getWorkingDirectory() .. "/update.ini" 

local script_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/BindCNN10.lua"
local script_path = thisScript().path

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	health = getCharHealth(PLAYER_PED)

	sampAddChatMessage("[BindCNN] Биндер для CNN", main_color)
	sampAddChatMessage("[BindCNN] Активация - /bmenu", main_color)
	sampAddChatMessage("[BindCNN] Разработчик - Kevin_McWood", main_color)

	sampRegisterChatCommand("bmenu", cmd_bmenu)
	sampRegisterChatCommand("invv", invv)
	sampRegisterChatCommand("clearchat", clearchat)
	sampRegisterChatCommand("update", cmd_update)


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
                    sampAddChatMessage("Скрипт успешно обновлен!", -1)
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
			sampSendChat("Удачной Вам работы!")
		end
	end)
end


function imgui.OnDrawFrame()

	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
  	imgui.SetNextWindowSize(imgui.ImVec2(620, 650), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"BindCNN", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	imgui.TextColored(imgui.ImVec4(0, 1, 0, 1), u8'Версия: ', script_version)

	imgui.BeginChild('##1', imgui.ImVec2(200, 175), true)
		imgui.Text(u8"Ваш ник: " ..nick.. "[" ..id.. "]")
		imgui.ToggleButton(u8"Женские отыгровки", women)
	imgui.EndChild()

	imgui.SetCursorPos(imgui.ImVec2(210, 43))
	imgui.BeginChild('##2', imgui.ImVec2(200, 175), true)
		for i, value in ipairs(themes.colorThemes) do
			if imgui.RadioButton(value, checked_radio, i) then
				themes.SwitchColorThemes(i)
			end
		end
	imgui.EndChild()

	imgui.SetCursorPos(imgui.ImVec2(4, 225))
	imgui.BeginChild('##4', imgui.ImVec2(200, 175), true)
		imgui.Text(u8"/bmenu - меню скрипта\n/invv - отыгровка принятия игрока")
	imgui.EndChild()

	imgui.SetCursorPos(imgui.ImVec2(415, 43))
	imgui.BeginChild('##3', imgui.ImVec2(200, 175), true)
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
		if imgui.Button(u8'пїЅпїЅпїЅпїЅпїЅпїЅ 3 - пїЅпїЅпїЅпїЅпїЅ пїЅпїЅ', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("пїЅпїЅпїЅпїЅпїЅпїЅ 3.")
			end)
		end
	imgui.EndChild()
	imgui.SetCursorPos(imgui.ImVec2(0, 580))
	if imgui.Button(u8"Перезапустить скрипт", imgui.ImVec2(145,58)) then
		thisScript():reload()
	end
	imgui.End()
end


