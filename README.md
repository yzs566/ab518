
UnityEngine.QualitySettings.SetQualityLevel(1);
UnityEngine.Time.timeScale = 1;
if GameBug == nil then
    GameBug = {};
    GameBug.bugButten = {};
    GameBug.bugLog = {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
    GameBug.GameUpdateFun = {};
    GameBug.ver = "Ver.0.01";
    local image = GameObject.Find("Global_UI/Canvas/TopMask").transform:GetComponent("Image");
    image.raycastTarget = true;
end
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
    GameBug.myGold = (UserData.GetGold()/10000);
    GameBug.bugLog[1] = GameBug.ver.."\nGold="..GameBug.myGold.."\n"..GameDataConst.enterGameName;
    if GameDataConst.enterGameName == "" then
        GameBug.bugButten = {};
        GameBug.GameUpdateFun = {};
        CtrlManager.Close(CtrlNames.WindowMask);
    else
        GameBug.bugButten[1] = GameDataConst.enterGameName;
    end
    if GameBug.GameUpdateFun ~= #GameBug.GameUpdateFun then
        for k, v in pairs(GameBug.GameUpdateFun) do
            if v ~= nil then
    -- DebugLog.LogError("--------GameBug.Update()------------"..k)
                v();
            end
        end
    end
end
function GameBug.LoadGame(logline)
    local www = ExWWW.WWW(string.gsub( AppConst.luaAsset , "test.lua", string.lower(GameDataConst.enterGameName)..".lua" ));
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
