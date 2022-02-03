script_author("McWood")
script_version('03.12.2021')

require "lib.moonloader"
local dlstatus = require('moonloader').download_status

local keys = require "vkeys"
local imgui = require "imgui"
local encoding = require "encoding"
local fa = require 'fAwesome5' --������ �������� ����� ����
local sampev = require 'lib.samp.events'
local bNotf, notf = pcall(import, "imgui_notf.lua")

encoding.default = 'CP1251'
u8 = encoding.UTF8

local rkeys = require 'rkeys'
local gkey = require 'game.keys'
imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar

update_state = false

local themes = import "resource/imgui_themes.lua"

local idn, itext = -1, ''

local label = 0
local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"

local inicfg = require 'inicfg'
local directIni = "moonloader\\resource\\settings.ini"
local mainIni = inicfg.load({
    config = {
    jensk = false,
    yvedoml = false,
    themesohr = 1,
    bind1 = false,
    }
}, directIni)
if not doesFileExist(directIni) then
    inicfg.save(mainIni, directIni)
end

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local sw, sh = getScreenResolution()
local women = imgui.ImBool(mainIni.config.jensk)
local yved = imgui.ImBool(mainIni.config.yvedoml)
local checked_radio = imgui.ImInt(mainIni.config.themesohr)
local bind = imgui.ImBool(mainIni.config.bind1)

local script_vers = 1.9
local script_vers_text = "1.9"

local update_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/KevinMcWood/bindcnn/main/BindCNN10.lua"
local script_path = thisScript().path

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end
--������
local tab = imgui.ImInt(1)
local tabs = {
    fa.ICON_FA_GLOBE_ASIA..u8' ��������',
    fa.ICON_FA_COGS..u8' ���������',
    fa.ICON_FA_FILE_ALT..u8' �������',
    fa.ICON_FA_SPINNER..u8' �����',
    fa.ICON_FA_SPINNER..u8' ����',
    fa.ICON_FA_SPINNER..u8' ������(VR)',
    fa.ICON_FA_SPINNER..u8' ������',
    fa.ICON_FA_SPINNER..u8' ��������� �����',
    fa.ICON_FA_SPINNER..u8' ���������� � �������',
}



function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    health = getCharHealth(PLAYER_PED)

    sampAddChatMessage("[BindCNN10] ������ ��� CNN", main_color)
	sampAddChatMessage("[BindCNN10] �����: Kevin McWood", main_color)

    sampRegisterChatCommand("bmenu", cmd_bmenu)
    sampRegisterChatCommand("invv", invv)
    sampRegisterChatCommand('cc', ClearChat)
    sampRegisterChatCommand("vig", cmd_vig)
	sampRegisterChatCommand("unnvig", cmd_unvig)
	sampRegisterChatCommand("exp", cmd_exp)
	sampRegisterChatCommand("fmt", cmd_fmt)
	sampRegisterChatCommand("unfmt", cmd_fmt)

    imgui.Process = false

    imgui.SwitchContext()
    themes.SwitchColorThemes(mainIni.config.themesohr)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                if not yved.v == false then
                notf.addNotification(("����� ����� ����������!"), 5, 1)
                end
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
                    if not yved.v == false then
                    notf.addNotification(("������ ������� ��������!"), 5, 1)
                    end
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
		sampSendChat("/invite " ..idpl)
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
		sampSendChat("/invite " ..idpl)
		wait(2000)
		sampSendChat("������� ��� ������!")
    end
    end)
end
-- ������� ����, �� �������!
function ClearChat()
    local memory = require "memory"
    memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
    memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
    memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
    if not yved.v == false then
        notf.addNotification(("�� ������� �������� ���!"), 5, 1)
    end
end

function cmd_vig(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me ���� �� ������� ������� � ����� � ���� ������ �����������...")
        wait(2000)
        sampSendChat("/me ...����� ���� ������� ���������� � ����������, ������ '�������'")
        wait(2000)
        sampShowDialog(1000, "������� ������ ���������", "������� id ������ � �������\n19,��������� ������", "������",'������', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/fwarn "..idn..' '..itext)
        end
        if not yved.v == false then
            notf.addNotification(("������� ������� �������!"), 5, 1)
        end
    end)
end

function cmd_exp(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
    local _, idpl = sampGetPlayerIdByCharHandle(ped)
    lua_thread.create(function ()
        sampSendChat("/me ���� �������� �� ������ � ����� �� �����")
        wait(2000)
        sampSendChat("/todo � ��������� ��� ������ ����� ���� �����*��������� �������� �� �����������")
        wait(2000)
        sampShowDialog(1000, "������� ��������� ������", "������� id ������ � �������\n19,��������� �������", "��������",'������', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/expel "..idn..' '..itext)
        end
        if not yved.v == false then
            notf.addNotification(("�� ������� ������."), 5, 1)
        end
    end)
end

function cmd_fmt(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
	local _, idpl = sampGetPlayerIdByCharHandle(ped)
	lua_thread.create(function ()
        sampSendChat("/me ���� �� ������� ������� � ����� � ���� ������ �����������...")
        wait(2000)
        sampSendChat("/me ...����� ���� ������������ ������ � ����� � ����������")
        wait(2000)
        sampShowDialog(1000, "������� ������ �����", "������� id ������ � �������\n19,���������", "������",'������', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/fmute "..idn..' '..itext)
        end
        if not yved.v == false then
            notf.addNotification(("�� ������� ������ ���!"), 5, 1)
        end
	end)
end

function cmd_unfmt(arg)
	local _, ped = storeClosestEntities(PLAYER_PED)
	local _, idpl = sampGetPlayerIdByCharHandle(ped)
	lua_thread.create(function ()
        sampSendChat("/me ���� �� ������� ������� � ����� � ���� ������ �����������...")
        wait(2000)
        sampSendChat("/me ...����� ���� ������������� ������ � ����� � ����������")
        wait(2000)
        sampShowDialog(1000, "������� ������ �����", "������� id ������ � �������\n19,���������", "������",'������', 1)
        while sampIsDialogActive(6406) do wait(100) end
        local result, button, list, input = sampHasDialogRespond(6406)
        if input:find('(%d+),(.+)') and button == 1 then
            idn, itext = input:match('(%d+),(.+)')
            sampSendChat("/funmute "..idn..' '..itext)
        end
        if not yved.v == false then
            notf.addNotification(("�� ������� ����� ���!"), 5, 1)
        end
    end)
end

function imgui.OnDrawFrame()
    local X, Y = getScreenResolution()
    imgui.SetNextWindowSize(imgui.ImVec2(700, 440), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(X / 2, Y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin('�', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.SetCursorPos(imgui.ImVec2(0, 45))
        if imgui.CustomMenu(tabs, tab, imgui.ImVec2(135, 30), _, true) then
            --������ ������� �� ���� ���������. �� �������
        end
        imgui.SetCursorPos(imgui.ImVec2(150, 35))
        imgui.BeginChild('##main', imgui.ImVec2(700, 400), true)
            if tab.v == 1 then --��������
                imgui.Text(u8"��� ���: " ..nick.. "[" ..id.. "]")
            elseif tab.v == 2 then -- ���������
                if imgui.Checkbox(u8"������� ���������", women) then
                    mainIni.config.jensk = women.v
                    inicfg.save(mainIni, directIni)
                end                
                imgui.SameLine()
                imgui.TextQuestion("( ? )",u8"��� ��������� ��������� ����� ��������")
                if imgui.Checkbox(u8"�����������", yved) then
                    mainIni.config.yvedoml = yved.v
                    inicfg.save(mainIni, directIni)
                end 
                imgui.SameLine()
                imgui.TextQuestion("( ? )",u8"��� ��������� � ��� �� ����� ������������� �����������")
                if imgui.Checkbox(u8"�������", bind) then
                    mainIni.config.bind1 = bind.v
                    inicfg.save(mainIni, directIni)
                end  
                imgui.SameLine()
                imgui.TextQuestion("( ? )",u8"��� ��������� � ��� �� ����� �������� ������� '�������' � ����� ������������ ����������� ���������")
            elseif tab.v == 3 then -- �������
                imgui.Text(u8"/bmenu - ���� �������\n/invv - �������� ������\n/cc - �������� ���\n/vig - ������ �������\n/unvig - ����� �������( � ����)\n/exp - ������� ��������\n/fmt - ������ ���\n/unfmt - ����� ���")
            elseif tab.v == 4 then --������ �������
                if imgui.Button(u8'���������� ������', imgui.ImVec2(150, 30)) then
                    sampSendChat("/stats")
                end
                if imgui.Button(u8'���������� ������', imgui.ImVec2(150, 30)) then
                    sampSendChat("/jobprogress")
                end
                if imgui.Button(u8'�������', imgui.ImVec2(150, 30)) then
                    sampSendChat("/showpass " ..id)
                end
                if imgui.Button(u8'��������', imgui.ImVec2(150, 30)) then
                    sampSendChat("/showlic " ..id)
                end
            elseif tab.v == 5 then -- ����
                for i, value in ipairs(themes.colorThemes, mainIni.config.themesohr) do
                    if imgui.RadioButton(value, checked_radio, i) then
                        mainIni.config.themesohr = checked_radio.v
                        inicfg.save(mainIni, directIni)
                        themes.SwitchColorThemes(i)
                    end
                end
            elseif tab.v == 6 then -- ����
                imgui.Text(u8'ss')
            elseif tab.v == 7 then -- ������
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
                imgui.SetCursorPos(imgui.ImVec2(160, 4))
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
                imgui.SetCursorPos(imgui.ImVec2(320, 4))
                if imgui.Button(u8'������ 3 - �.�.�', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("������������, ������� �������!")
                        wait(2000)
                        sampSendChat("������ � ��� ������� ������ �� ���� '�.�.�'")
                        wait(2000)
                        sampSendChat("'�.�.�' - ������� �������������� ����������.")
                        wait(2000)
                        sampSendChat("������ ��������� ������ ����������� ������ �����...")
                        wait(2000)
                        sampSendChat("...��� ����� �.�.�, � ��� ��� ���������.")
                        wait(2000)
                        sampSendChat("� ������ ���� ��������� �� ����� �.�.�, �� ���� ����� �������� �������...")
                        wait(2000)
                        sampSendChat(".. ����� ���: ������ ��������������, �������, ���������, ����������.")
                        wait(2000)
                        sampSendChat("����� �������� � ����� ��������� �� ������ ������������ ����� ���.������ �����.")
                        wait(2000)
                        sampSendChat("/b ���� � ���� ��������-> forum.arizona-rp.com")
                        wait(2000)
                        sampSendChat("/b ����� -> ������ �5 [ Brainburg ] -> ���.���������")
                        wait(2000)
                        sampSendChat("/b -> Mass Media | �������� �������� ���������� -> ������� �������������� ����������")
                        wait(2000)
                    end)
                end
                if imgui.Button(u8'������ 4 - ������', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("��������� �������, ��������� ��������, ������ � ������� ��� ������ �� ���� '������'")
                        wait(2000)
                        sampSendChat("������ - ���������� ���������� �������������. � ������ ����� ���� ����� ����...")
                        wait(2000)
                        sampSendChat("... ���� �� ������� � ����������, ������ � ������, ������� ���� ����, � ��� �� ���������� � ������.")
                        wait(2000)
                        sampSendChat("��� ���� ���-�� ������ ������ ����� ����� �������, � ��� �� �������!")
                        wait(2000)
                        sampSendChat("/b ��� ����������� �������!")
                        wait(2000)
                        sampSendChat("��� ����� ������ ���������� ������!")
                        wait(2000)
                        sampSendChat("/b ��� ������ ������ ��������� � ������ ����� �����������.")
                        wait(2000)
                        sampSendChat("��� �������� ������� ������, �� ������ ������ �������������.")
                        wait(2000)
                        sampSendChat("/b ������� �������� ���� ����, � ���������� � ������ ������.")
                        wait(2000)
                        sampSendChat("��� ������ �������� � ��� ���� ���������.")
                        wait(2000)
                        sampSendChat("/b ����� �������� ���� ����������, �� ������� ������ �������� ������.")
                        wait(2000)
                        sampSendChat("����� ���� ��� �� ��� �������, �� ������ ��������������� ��������� � ����������� ������� �����.")
                        wait(2000)
                        sampSendChat("/b ��������� ���������� ��������.")
                        wait(2000)
                        sampSendChat("������ �� ���� '������' ��������.")
                        wait(2000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(160, 38))
                if imgui.Button(u8'������ ��������', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/do ����� �� �����.")
                        wait(2000)
                        sampSendChat("/me ��������� ���� �������� ����� � ����")
                        wait(2000)
                        sampSendChat("/do ������ �� �����.")
                        wait(2000)
                        sampSendChat("/me ������ ����� ������� �� ����� �����")
                        wait(2000)
                        sampSendChat("/do ����� �������.")
                        wait(2000)
                        sampSendChat("/do � ����� ����������� � ���������� �.���-�������")
                        wait(2000)
                        sampSendChat("/todo ��� �������*��������� �������� �������� �� ������")
                        wait(2000)
                        sampSendChat("/do � �������� ��������")
                        wait(2000)
                        sampSendChat("/do ������� ��������, ������� ������, ������� ����������")
                        wait(2000)
                        sampSendChat("/do ������������� � ����� �����������.")
                        wait(2000)
                    end)
                end
            elseif tab.v == 8 then -- �������
                if imgui.Button(u8'/gov - ��� ��', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                    sampSendChat("/gov [CNN LV] ��������� ������ �����, ����� ��������� ��������..")
                    wait(6000)
                    sampSendChat("/gov [CNN LV] � ����� ������������ �.���-�������� �������� �������������.")
                    wait(6000)
                    sampSendChat("/gov [CNN LV] ��� ���� ��������. ��� ���� �����: �������, ���.�����, ����� ��������.")
                    wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(160, 4))
                if imgui.Button(u8'������� ��� ��', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� ����� ��������� ������ �����.")
                        wait(6000)
                        sampSendChat("/news �� ���������� ��� �� ������������� � ���������� ��� �.���-��������.")
                        wait(6000)
                        sampSendChat("/news ��� ��, �� ����� ������ ����������� ��� ���������� ������ �� 200.000$")
                        wait(6000)
                        sampSendChat("/news ������ � ��������� �������� ������� ����� ����� ��� ��������.")
                        wait(6000)
                        sampSendChat("/news ����� ����� ���������� � ��� ����� ����� �������� ����������� � �������")
                        wait(6000)
                        sampSendChat("/news ����� �� ������� ���������� ���� ������ ���������.")
                        wait(6000)
                        sampSendChat("/news � ����� ��� ���������� 'и������' �� ������� ��������� �����.")
                        wait(6000)
                        sampSendChat("/news �� ������� ������� ���������� �� 1.000.000$ �� 5.000.000$")
                        wait(6000)
                        sampSendChat("/news ��� ������� �� � ��� ���������� ��� ������� ������ ���� � ������������.")
                        wait(6000)
                        sampSendChat("/news ����� ��������� � ��� �� ������ ��� ����� ����� ������� � 3-������� ���������")
                        wait(6000)
                        sampSendChat("/news ���.����� � ������� �� ������� ���������� � ������� �������� � ������������.")
                        wait(6000)
                        sampSendChat("/news ���������� ��� � ��� �.���-��������, ��� ��� � ����� �����������!")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(315, 4))
                if imgui.Button(u8'��������� ������', imgui.ImVec2(150, 30)) then
                    sampSendChat(u8'������ �����.')
                end
                imgui.SetCursorPos(imgui.ImVec2(4, 38))
                if imgui.Button(u8'������� ����', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news ������ ������ ����������� ���� � ���� ������� ������� ��������? ��� ��...")
                        wait(6000)
                        sampSendChat("/news ...������ �������� ������ �������� ��������� �������� 2 �����")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ��� ������ �������� ������������� � �������� �.���-������")
                        wait(6000)
                        sampSendChat("/news ��� ����: ������� ��������, ���������� ������ � �������������� ���������.")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������������� ��� ����� ��������� 3 ���� � �����...")
                        wait(6000)
                        sampSendChat("/news ... � ����� ��� ���� �������,��� ����� � ����� �������� � ���� ���������������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� �������� ������ ���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(160, 38))
                if imgui.Button(u8'������� ����', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news ������ ������ ����������� ���� � ���� ������� ������� ��������? ��� ��...")
                        wait(6000)
                        sampSendChat("/news ...������ �������� ������ �������� ��������� �������� 2 �����")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ��� ������ �������� ������������� � �������� �.���-���������")
                        wait(6000)
                        sampSendChat("/news ��� ����: ������� ��������, ���������� ������ � �������������� ���������.")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������������� ��� ����� ��������� 3 ���� � �����...")
                        wait(6000)
                        sampSendChat("/news ... � ����� ��� ���� �������,��� ����� � ����� �������� � ���� ���������������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� �������� ������ ���-��������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(315, 38))
                if imgui.Button(u8'������� ����', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news ������ ������ ����������� ���� � ���� ������� ������� ��������? ��� ��...")
                        wait(6000)
                        sampSendChat("/news ...������ �������� ������ �������� ��������� �������� 2 �����")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ��� ������ �������� ������������� � �������� �.���-������")
                        wait(6000)
                        sampSendChat("/news ��� ����: ������� ��������, ���������� ������ � �������������� ���������.")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������������� ��� ����� ��������� 3 ���� � �����...")
                        wait(6000)
                        sampSendChat("/news ... � ����� ��� ���� �������,��� ����� � ����� �������� � ���� ���������������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� �������� ������ ���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(4, 72))
                if imgui.Button(u8'������� ���', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������ ���� ����, ������ ���������� ������ ���-��������.")
                        wait(6000)
                        sampSendChat("/news �� ������ ������ ������� � ������ ������� �����?")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������� ��� � ������ ���� �����? ����� ��� ��� ����!")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������ � ������ ������ ���-������.")
                        wait(6000)
                        sampSendChat("/news ��� ���� ����� ����� ����������,������� � ���.�����,���� � �������� ����.")
                        wait(6000)
                        sampSendChat("/news ������ �������� � ���������� ������ ���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(160, 72))
                if imgui.Button(u8'������� ���', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news �� ������ ������� �������� ���� �� ������������? ������ ������ �����?")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������ � ������ ��� ��� �������� ������������� � ������ �������� ������.")
                        wait(6000)
                        sampSendChat("/news ������ ��� ��� ���� ������� ���������� �����...")
                        wait(6000)
                        sampSendChat("/news ...��������� ���� � ������� ���������.")
                        wait(6000)
                        sampSendChat("/news � �� ��������� ,�� ���� ������� � ������ ��� ������� ����� �������� ����������.")
                        wait(6000)
                        sampSendChat("/news ��������: ����� ������ ����� ����������, ��������� � ����� �� ����� 3-� ���...")
                        wait(6000)
                        sampSendChat("/news ...���� ��������������� ����������� � ����� �������� ���.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ���������� ������ ���-��������. �� �������� ���� ����")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(315, 72))
                if imgui.Button(u8'������� ���', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������ ���� ����, ������ ���������� ������ ���-��������.")
                        wait(6000)
                        sampSendChat("/news �� ������ ������ ������� � ������ ������� �����?")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������� ��� � ������ ���� �����? ����� ��� ��� ����!")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������ � ������ ������ ���-������.")
                        wait(6000)
                        sampSendChat("/news ��� ���� ����� ����� ����������,������� � ���.�����,���� � �������� ����.")
                        wait(6000)
                        sampSendChat("/news ������ �������� � ���������� ������ ���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(4, 106))
                if imgui.Button(u8'������� ����', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������������� � ����������� ����������� �.���-������.")
                        wait(6000)
                        sampSendChat("/news ��� ����: ������� ��������, ���������� ������ � �������������� ���������.")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������������� ��� ����� ����� ��� ����...")
                        wait(6000)
                        sampSendChat("/news ..�������,���.�����,������� ����� � ���� ��������������� �����������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� ������������ ������� �.���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(160, 106))
                if imgui.Button(u8'������� ����', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������������� � ����������� ����������� �.���-��������.")
                        wait(6000)
                        sampSendChat("/news ��� ����: ������� ��������, ���������� ������ � �������������� ���������.")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������������� ��� ����� ����� ��� ����...")
                        wait(6000)
                        sampSendChat("/news ..�������,���.�����,������� ����� � ���� ��������������� �����������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� ������������ ������� �.���-��������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(315, 106))
                if imgui.Button(u8'������� ����', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news ������ �������� ������������� � ����������� ����������� �.���-������")
                        wait(6000)
                        sampSendChat("/news ��� ����: ������� ��������, ���������� ������ � �������������� ���������.")
                        wait(6000)
                        sampSendChat("/news ����� ������ ������������� ��� ����� ����� ��� ����...")
                        wait(6000)
                        sampSendChat("/news ..�������,���.�����,������� ����� � ���� ��������������� �����������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� ������������ ������� �.���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(4, 140))
                if imgui.Button(u8'������� ����-��', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news �� ������ ������ �������� � ��������? ���� ������������ � �����������?")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ��� �������� ������������� � ����� ������ ��� ������.")
                        wait(6000)
                        sampSendChat("/news �������� ��������� ����,������� ��������,����������� ���������.")
                        wait(6000)
                        sampSendChat("/news ��������: ����� ����� ����������,������� � ���.�����,���� � �������� ����.")
                        wait(6000)
                        sampSendChat("/news ����� ���� ��������������� �����������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� ����� ������ �.���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(160, 140))
                if imgui.Button(u8'������� ��', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news �� ������ ������ ����������� ���� � ���������� ����? ��� ��...")
                        wait(6000)
                        sampSendChat("/news ...��������� ���� �������� �� �������?")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ��� ������ �������� ������������� � ����������� ����.")
                        wait(6000)
                        sampSendChat("/news ������ ���, �� ������, ����������� �� ������� ����� ������ ������!")
                        wait(6000)
                        sampSendChat("/news ��������: �� 3-� ��� � �����, ����� ����� ����������, � ��� �� ����...")
                        wait(6000)
                        sampSendChat("/news ...��������������� � ���� ������� ������..")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����������� ����� �.���-������. ���� ������ ���.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                imgui.SetCursorPos(imgui.ImVec2(315, 140))
                if imgui.Button(u8'������� ���', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������� ������� �����, ��������� ��������������.")
                        wait(6000)
                        sampSendChat("/news �� ������ ������ �������� � ��������? ���������� ��������� ����� ���� ��� ������������?")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ��� �������� ������������� � ��������� �������� �.���-������.")
                        wait(6000)
                        sampSendChat("/news ��� ����: �������� ��������� ����, ������� ��������, ����������� ���������.")
                        wait(6000)
                        sampSendChat("/news ��������: ����� ����� ����������, ������� � ���.�����, ���� � �������� ����.")
                        wait(6000)
                        sampSendChat("/news ����� ���� ��������������� �����������.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� ��������� �������� �. ���-������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
                if imgui.Button(u8'������� ��', imgui.ImVec2(150, 30)) then
                    lua_thread.create(function ()
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                        sampSendChat("/news ������ ���� ����, ������� ���������� �.���-��������.")
                        wait(6000)
                        sampSendChat("/news ���� ����� ������� �����? �������� ������ ����� ����� ������?")
                        wait(6000)
                        sampSendChat("/news ����� ������ ��� ����! ������ �������� ������������� � ����� ��������������!")
                        wait(6000)
                        sampSendChat("/news ��� ���� ������ � ���������� ��������� � �������������� ����������!")
                        wait(6000)
                        sampSendChat("/news ��������: �������� �� 3-� ���,����� ������� � ���.�����. ���� � �������� ����.")
                        wait(6000)
                        sampSendChat("/news ������������� �������� � ����� ����� ������ ��������������.")
                        wait(6000)
                        sampSendChat("/news ��������� ����������� �������� ����������� �.���-�������� ���������")
                        wait(6000)
                    end)
                end
            elseif tab.v == 9 then -- ���� � �������
                imgui.Text(u8'������ �������: ' ..script_vers)
                imgui.Text(u8'����� �������: Kevin_McWood')
            end
        imgui.EndChild()
    imgui.End()
end

--��������� ����
function imgui.CustomMenu(labels, selected, size, speed, centering)
    local bool = false
    speed = speed and speed or 0.2
    local radius = size.y * 0.50
    local draw_list = imgui.GetWindowDrawList()
    if LastActiveTime == nil then LastActiveTime = {} end
    if LastActive == nil then LastActive = {} end
    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
    for i, v in ipairs(labels) do
        local c = imgui.GetCursorPos()
        local p = imgui.GetCursorScreenPos()
        if imgui.InvisibleButton(v..'##'..i, size) then
            selected.v = i
            LastActiveTime[v] = os.clock()
            LastActive[v] = true
            bool = true
        end
        imgui.SetCursorPos(c)
        local t = selected.v == i and 1.0 or 0.0
        if LastActive[v] then
            local time = os.clock() - LastActiveTime[v]
            if time <= 0.3 then
                local t_anim = ImSaturate(time)
                t = selected.v == i and t_anim or 1.0 - t_anim
            else
                LastActive[v] = false
            end
        end
        local col_bg = imgui.GetColorU32(selected.v == i and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.ImVec4(0,0,0,0))
        local col_box = imgui.GetColorU32(selected.v == i and imgui.GetStyle().Colors[imgui.Col.Button] or imgui.ImVec4(0,0,0,0))
        local col_hovered = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
        local col_hovered = imgui.GetColorU32(imgui.ImVec4(col_hovered.x, col_hovered.y, col_hovered.z, (imgui.IsItemHovered() and 0.2 or 0)))
        draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + t * size.x, p.y + size.y), col_bg, 10.0)
        draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + size.x, p.y + size.y), col_hovered, 10.0)
        draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x+5, p.y + size.y), col_box)
        imgui.SetCursorPos(imgui.ImVec2(c.x+(centering and (size.x-imgui.CalcTextSize(v).x)/2 or 15), c.y+(size.y-imgui.CalcTextSize(v).y)/2))
        imgui.Text(v)
        imgui.SetCursorPos(imgui.ImVec2(c.x, c.y+size.y))
    end
    return bool
end

--(?)
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
-- ������ ����������!
function sampev.onServerMessage(color, text)
    if text:find("�� ��������� ���������� ������ ��������� ��:") then
        printStyledString("NEW ADD", 500, 2) 
    end
	if text:find("�� �������� ���������� ������ VIP ��������� ��:") then
        printStyledString("MEW VIP ADD", 500, 2) 
    end
end
