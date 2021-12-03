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
local script_vers_text = "5.1"

local update_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/BindCNN10.lua" -- ��� ���� ������
local script_path = thisScript().path

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	health = getCharHealth(PLAYER_PED)

	sampAddChatMessage("������ ��� CNN", main_color)

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
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("������ ������� ��������!", -1)
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
		sampSendChat("������������, �� ������ � ��� �� �������������?")
		wait(2000)
		sampAddChatMessage("��� ����������� ������� -1; ��� ������ ������� - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("������� ��������", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
    	sampSendChat("������, �������� ���� ���������, � ������: �������, ���.����� � ��������")
		wait(2000)
		sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
		wait(2000)
		sampAddChatMessage("��� ����������� ������� -1; ��� ������ ������� - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("������� ��������", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("/me ���������� ��������� ���� ���� ��������� � �������� ��������")
		wait(2000)
		sampSendChat("/todo ���, ������, ��� ����...*�������� ���������")
		wait(2000)
		sampSendChat("/me ���������� ��������� ���� ������ ��������� �������� ��������")
		wait(2000)
		sampAddChatMessage("�������� - 1; �� �������� - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampSendChat("� ���������, �� ��� �� ���������.")
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("�������. �� ��� ���������. ������ � ����� ��� ����� � ���� �� ��������")
		wait(2000)
		sampSendChat("/me ������ ���������� � ������� ����� �� ������ � ��������� ���...")
		wait(2000)
		sampSendChat("/me ...���� ����� � ���� ����� " ..idpl)
		wait(2000)
		sampSendChat("������� ��� ������!")
		end

	if not women.v == false then
		sampSendChat("������������, �� ������ � ��� �� �������������?")
		wait(2000)
		sampAddChatMessage("��� ����������� ������� -1; ��� ������ ������� - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("������� ��������", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
    	sampSendChat("������, �������� ���� ���������, � ������: �������, ���.����� � ��������")
		wait(2000)
		sampSendChat("/n /showpass " ..id.. " | /showmc " ..id.. " | /showlic " ..id)
		wait(2000)
		sampAddChatMessage("��� ����������� ������� -1; ��� ������ ������� - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampAddChatMessage("������� ��������", main_color)
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("/me ���������� ��������� ���� ����� ��������� � �������� ��������")
		wait(2000)
		sampSendChat("/todo ���, ������, ��� ����...*�������� ���������")
		wait(2000)
		sampSendChat("/me ���������� ��������� ���� ������� ��������� �������� ��������")
		wait(2000)
		sampAddChatMessage("�������� - 1; �� �������� - 2", 0xFF8C00)
		wait(2000)
		repeat
		wait(10)
    	if isKeyJustPressed(VK_2) then
			sampSendChat("� ���������, �� ��� �� ���������.")
    	return
    	end
		until isKeyJustPressed(VK_1)
		sampSendChat("�������. �� ��� ���������. ������ � ����� ��� ����� � ���� �� ��������")
		wait(2000)
		sampSendChat("/me ������ ����������� � ������� ����� �� ������ � ��������� ���...")
		wait(2000)
		sampSendChat("/me ...����� ����� � ���� ����� " ..idpl)
		wait(2000)
		sampSendChat("������� ��� ������!")
	end
	end)
end


function imgui.OnDrawFrame()

	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
  	imgui.SetNextWindowSize(imgui.ImVec2(620, 650), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"BindCNN", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	imgui.TextColored(imgui.ImVec4(0, 1, 0, 1), u8'������: ', script_version)

	imgui.BeginChild('##1', imgui.ImVec2(200, 175), true)
		imgui.Text(u8"��� ���: " ..nick.. "[" ..id.. "]")
		imgui.ToggleButton(u8"������� ���������", women)
	imgui.EndChild()

	imgui.SetCursorPos(imgui.ImVec2(210, 43))
	imgui.BeginChild('##2', imgui.ImVec2(200, 175), true)
		for i, value in ipairs(themes.colorThemes) do
			if imgui.RadioButton(value, checked_radio, i) then
				themes.SwitchColorThemes(i)
			end
		end
	imgui.EndChild()

	if imgui.CollapsingHeader(u8"�������") then
		imgui.Text(u8"/bmenu - ���� �������\n/invv - ��������� �������� ������\n/clearchat - �������� ���")
	end

	imgui.SetCursorPos(imgui.ImVec2(415, 43))
	imgui.BeginChild('##3', imgui.ImVec2(200, 175), true)
		if imgui.Button(u8'������ 1 - ����.�����', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("/r ������������, ������� �������!")
				wait(2000)
				sampSendChat("/r ������ � ���� ��� ���������� � ����� '���� ����� �������'.")
				wait(2000)
				sampSendChat("/r ������ ����. ����� ����� ����� ��������� ���� �����������, ������� � �������.")
				wait(2000)
				sampSendChat("/r ��� ������������� ��� ������� �������� ���������� ����� ������������")
				wait(2000)
				sampSendChat("/r ���-�� ���������� � ����� ������")
				wait(2000)
				sampSendChat("/rb ��� ����� ������! ��� ��� � ���� ���� - https://discord.gg/brainburg")
				wait(2000)
				sampSendChat("/rb ������ ��� �� ����� [CNN LS][1] Nick_Name")
				wait(2000)
				sampSendChat("/rb ����� � ����� #������-���� � �������� ������ '��������� ���� �����������'")
				wait(2000)
				sampSendChat("/rb ����� ���� ��� ��� ������� ���� ������� ���� � ������������ � ����� ��� | LVFM")
				wait(2000)
			end)
		end
		if imgui.Button(u8'������ 2 - ������������', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("������������, ������� �������!")
				wait(2000)
				sampSendChat("������ � ������� ������ �� ���� '������������'.")
				wait(2000)
				sampSendChat("������������ - ��� ������� ������� ����� ������")
				wait(2000)
				sampSendChat("� ����� ����������� ������� ������ �� ��!")
				wait(2000)
				sampSendChat("�� ������� � �������� � ������������ ������������� �����������.")
				wait(2000)
				sampSendChat("� ��������� �� ��� �� ������� ���������� �� ��")
				wait(2000)
				sampSendChat("�� ���� ������ �� ���� '������������' ��������")
				wait(2000)
			end)
		end
		if imgui.Button(u8'������ 3 - ����� ��', imgui.ImVec2(150, 30)) then
			lua_thread.create(function ()
				sampSendChat("������ 3.")
			end)
		end
	imgui.EndChild()
	imgui.SetCursorPos(imgui.ImVec2(0, 580))
	if imgui.Button(u8"������������� ������", imgui.ImVec2(145,58)) then
		thisScript():reload()
	end
	imgui.End()
end


