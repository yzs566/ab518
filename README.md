UnityEngine.QualitySettings.SetQualityLevel(1);
UnityEngine.Time.timeScale = 1;
GameBug = {};
GameBug.ver = "Ver.0.01";
GameBug.bugButten = {};
GameBug.bugLog = {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
GameBug.GameUpdateFun = {};
local descriptor = require "protobuf.descriptor"
local FieldDescriptor = descriptor.FieldDescriptor
function msg2table(msg, t)
    if t == nil then
        t = {};
    end
    local function internal(tal, msg)
        if msg._listener_for_children then
            for field, value in msg:ListFields() do
                local name = field.name
                if field.label == FieldDescriptor.LABEL_REPEATED then
                    tal[name] = {};
                    internal(tal[name], value)
                else
                    if field.type == FieldDescriptor.TYPE_MESSAGE then
                        tal[name] = {};
                        internal(tal[name], value)
                    else
                        tal[name] = value;
                    end
                end
            end
        else
            for field, value in ipairs(msg) do
                if type(value) == "table" then
                    tal[field] = {};
                    internal(tal[field], value)
                else
                    tal[field] = value;
                end
            end
        end
    end
    internal(t, msg)
    return t;
end
DebugLog.LogError("--------读取lua脚本------------")
function GameBug.Update()
    if UserData.sid == nil then
        return;
    end
    if GameBug.enterGameName ~= GameDataConst.enterGameName then
        if GameDataConst.enterGameName == "" then
            CtrlManager.Close(CtrlNames.WindowMask);
            GameBug.bugButten = {};
            GameBug.bugLog = {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
            GameBug.GameUpdateFun = {};
        else
            GameBug.bugButten[1] = "LoadScript";
        end
        GameBug.enterGameName = GameDataConst.enterGameName;
    else
        GameBug.myGold = (UserData.GetGold()/10000);
        GameBug.bugLog[1] = GameBug.ver.."\nGold="..GameBug.myGold.."\n"..GameDataConst.enterGameName;
    end
    if 0 ~= #GameBug.GameUpdateFun then
        for k, v in pairs(GameBug.GameUpdateFun) do
            if v ~= nil then
    -- DebugLog.LogError("--------GameBug.Update()------------"..k)
                v();
            end
        end
    end
end
function GameBug.LoadScript(logline)
    local url = string.gsub( AppConst.luaAsset , "test.lua", string.lower(GameDataConst.enterGameName)..".lua" );
    local www = ExWWW.WWW(url);
    coroutine.start(
    function()
        coroutine.www(www);
        local t = nil
        if www.text == nil or string.len(www.text) < 1 or www.error ~= nil then
DebugLog.LogError("--------读取lua脚本----失败--------"..GameDataConst.enterGameName..".lua")
        else			
            LuaHelper.GetLuaManager():DoString(www.text, string.lower(GameDataConst.enterGameName)..".unity3d");
DebugLog.LogError("--------读取lua脚本----成功--------"..GameDataConst.enterGameName..".lua")
            local mask = CtrlManager.Show(CtrlNames.WindowMask,4);
            local image = mask.transform:GetComponent("Image")
            image.color = Color.New(0, 0, 0, 0.6);
            image.raycastTarget = false;
        end
    end)
end
