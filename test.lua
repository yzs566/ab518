UnityEngine.QualitySettings.SetQualityLevel(1);
UnityEngine.Time.timeScale = 1;
if GameBug == nil then
    GameBug = {};
    GameBug.bugButten = {};
    GameBug.bugLog = {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
    GameBug.GameUpdateFun = {};
    GameBug.ver = "Ver.0.01";
    local image = GameObject.Find("Global_UI/Canvas/TopMask").transform:GetComponent("Image")
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
function GameBug.DxTGame(logline)
    local mask = CtrlManager.Show(CtrlNames.WindowMask,4);
    local image = mask.transform:GetComponent("Image")
    image.color = Color.New(0, 0, 0, 0.75);
    image.raycastTarget = false;
    GameBug.DxTGameData = {};
    GameBug.DxTGameData.Round = 0;
    GameBug.DxTGameData.bunkoLYD = 0;
    GameBug.DxTGameData.bunkoLYD = 0;
    GameBug.DxTGameData.bunkoLYX = 0;
    GameBug.DxTGameData.bunkoHYD = 0;
    GameBug.DxTGameData.bunkoHYX = 0;
    GameBug.DxTGameData.bunkoHLD = 0;
    GameBug.DxTGameData.bunkoHHD = 0;
    GameBug.DxTGameData.bunkoLYX = 0;
    GameBug.DxTGameData.bunkoCL = 0;
    GameBug.DxTGameData.bunkoCH = 0;
    GameBug.DxTGameData.bunkoCD = 0;
    GameBug.DxTGameData.bunkoCX = 0;
    GameBug.DxTGameData.bunkoT = 0;
    GameBug.DxTGameData.bunkoDS = "";
    GameBug.DxTGameData.bunkoLH = "";
    GameBug.DxTGameData.bunkoLL = 0;
    GameBug.DxTGameData.bunkoHL = 0;
    GameBug.DxTGameData.bunkoDL = 0;
    GameBug.DxTGameData.bunkoXL = 0;
    GameBug.DxTGameData.roomState = 0;
    GameBug.DxTGameData.betMultiple = 1;
    GameBug.DxTGameData.betList = {1,2,4,8,16,32,64,128,256,512,1024,2048};
    GameBug.DxTGameData.RotList = {};
    GameBug.GameUpdateFun["DxTGame"] = function()
        GameBug.bugLog[logline] = "龙赢大="..GameBug.DxTGameData.bunkoLYD.."\n龙赢小="..GameBug.DxTGameData.bunkoLYX.."\n虎赢大="..GameBug.DxTGameData.bunkoHYD.."\n虎赢小="..GameBug.DxTGameData.bunkoHYX.."\n和龙大="..GameBug.DxTGameData.bunkoHLD.."\n和虎大="..GameBug.DxTGameData.bunkoHHD.."\n长龙="..GameBug.DxTGameData.bunkoCL.."\n长虎="..GameBug.DxTGameData.bunkoCH.."\n长大="..GameBug.DxTGameData.bunkoCD.."\n长小="..GameBug.DxTGameData.bunkoCX.."\nWin="..GameBug.DxTGameData.bunkoT.."\nRound="..GameBug.DxTGameData.Round.."\nstate="..GameBug.DxTGameData.roomState.."\n龙虎="..GameBug.DxTGameData.bunkoLH.."\n大小="..GameBug.DxTGameData.bunkoDS
    end
    GameBug.DxTGameData.gamectrl = CtrlManager.GetCtrl(CtrlNames.DTFightMain);
    if GameBug.DxTGameData.gamectrl == nil then
        DebugLog.LogError("--------注入脚本失败------------"..CtrlNames.DTFightMain)
    end
    Event.RemoveListener(tostring(DxTMid_pb.PushBunkoInfoMid));
    Event.AddListener(tostring(DxTMid_pb.PushBunkoInfoMid), function(args)
        local data = args:ReadBuffer();
        local msg = DxTProto_pb.PushBunkoInfo();
        msg:ParseFromString(data);
        local buffer = ByteBuffer.New();
        buffer:WriteBuffer(data);
        GameBug.DxTGameData.gamectrl:PushBunkoInfo(buffer:Clone());
        -- 1=龙 2=虎 3=和
        -- DebugLog.LogError("--------PushBunkoInfo------------"..msg.bunko)
        local long = tonumber(DTFightBetMoney[1].totalBet);
        local hu = tonumber(DTFightBetMoney[2].totalBet);
        GameBug.DxTGameData.bunko = msg.bunko;
        GameBug.DxTGameData.Round = GameBug.DxTGameData.Round +1;
        if GameBug.DxTGameData.bunko == 3 then
            if long > hu then
                GameBug.DxTGameData.bunkoHLD = GameBug.DxTGameData.bunkoHLD + 1;
                GameBug.DxTGameData.bunkoT = 5;
            -- DebugLog.LogError("\t和龙大\t"..(long - hu).."\t龙\t"..long.."\t虎\t"..hu.."\t秒押\t"..(GameBug.DxTGameData.long - GameBug.DxTGameData.hu).."\t龙\t"..GameBug.DxTGameData.long.."\t虎\t"..GameBug.DxTGameData.hu)
            else
                GameBug.DxTGameData.bunkoHHD = GameBug.DxTGameData.bunkoHHD + 1;
                GameBug.DxTGameData.bunkoT = 6;
            -- DebugLog.LogError("\t和虎大\t"..(hu - long).."\t龙\t"..long.."\t虎\t"..hu.."\t秒押\t"..(GameBug.DxTGameData.hu - GameBug.DxTGameData.long).."\t龙\t"..GameBug.DxTGameData.long.."\t虎\t"..GameBug.DxTGameData.hu)
            end
            return;
        end
        if GameBug.DxTGameData.bunko == 1 then
            if long > hu then
                GameBug.DxTGameData.bunkoLYD = GameBug.DxTGameData.bunkoLYD + 1;
                GameBug.DxTGameData.bunkoT = 1;
                GameBug.DxTGameData.bunkoDS = GameBug.DxTGameData.bunkoDS.."1";
            -- DebugLog.LogError("\t龙赢大\t"..(long - hu).."\t龙\t"..long.."\t虎\t"..hu.."\t秒押\t"..(GameBug.DxTGameData.long - GameBug.DxTGameData.hu).."\t龙\t"..GameBug.DxTGameData.long.."\t虎\t"..GameBug.DxTGameData.hu)
            else
                GameBug.DxTGameData.bunkoLYX = GameBug.DxTGameData.bunkoLYX + 1;
                GameBug.DxTGameData.bunkoT = 2;
                GameBug.DxTGameData.bunkoDS = GameBug.DxTGameData.bunkoDS.."2";
            -- DebugLog.LogError("\t龙赢小\t"..(long - hu).."\t龙\t"..long.."\t虎\t"..hu.."\t秒押\t"..(GameBug.DxTGameData.long - GameBug.DxTGameData.hu).."\t龙\t"..GameBug.DxTGameData.long.."\t虎\t"..GameBug.DxTGameData.hu)
            end
            GameBug.DxTGameData.bunkoLH = GameBug.DxTGameData.bunkoLH.."1";
        elseif GameBug.DxTGameData.bunko == 2 then
            if long < hu then
                GameBug.DxTGameData.bunkoHYD = GameBug.DxTGameData.bunkoHYD + 1
                GameBug.DxTGameData.bunkoT = 3;
                GameBug.DxTGameData.bunkoDS = GameBug.DxTGameData.bunkoDS.."1";
            -- DebugLog.LogError("\t虎赢大\t"..(hu - long).."\t龙\t"..long.."\t虎\t"..hu.."\t秒押\t"..(GameBug.DxTGameData.hu - GameBug.DxTGameData.long).."\t龙\t"..GameBug.DxTGameData.long.."\t虎\t"..GameBug.DxTGameData.hu)
            else
                GameBug.DxTGameData.bunkoHYX = GameBug.DxTGameData.bunkoHYX + 1;
                GameBug.DxTGameData.bunkoT = 4;
                GameBug.DxTGameData.bunkoDS = GameBug.DxTGameData.bunkoDS.."2";
            -- DebugLog.LogError("\t虎赢小\t"..(hu - long).."\t龙\t"..long.."\t虎\t"..hu.."\t秒押\t"..(GameBug.DxTGameData.hu - GameBug.DxTGameData.long).."\t龙\t"..GameBug.DxTGameData.long.."\t虎\t"..GameBug.DxTGameData.hu)
            end
            GameBug.DxTGameData.bunkoLH = GameBug.DxTGameData.bunkoLH.."2";
        end
        if string.len(GameBug.DxTGameData.bunkoDS) == 35 then
            GameBug.DxTGameData.bunkoDS = string.sub(GameBug.DxTGameData.bunkoDS, 20, 35);
            GameBug.DxTGameData.bunkoLH = string.sub(GameBug.DxTGameData.bunkoLH, 20, 35);
        end
        if GameBug.DxTGameData.bunko == 1 then
            GameBug.DxTGameData.bunkoLL = GameBug.DxTGameData.bunkoLL + 1;
            GameBug.DxTGameData.bunkoHL = 0;
            if GameBug.DxTGameData.bunkoLL > GameBug.DxTGameData.bunkoCL then
                GameBug.DxTGameData.bunkoCL = GameBug.DxTGameData.bunkoLL;
            end
        else
            GameBug.DxTGameData.bunkoHL = GameBug.DxTGameData.bunkoHL + 1;
            GameBug.DxTGameData.bunkoLL = 0;
            if GameBug.DxTGameData.bunkoHL > GameBug.DxTGameData.bunkoCH then
                GameBug.DxTGameData.bunkoCH = GameBug.DxTGameData.bunkoHL;
            end
        end
        if (long > hu and GameBug.DxTGameData.bunko == 1) or (long < hu and GameBug.DxTGameData.bunko == 2) then
            GameBug.DxTGameData.bunkoDL = GameBug.DxTGameData.bunkoDL + 1;
            GameBug.DxTGameData.bunkoXL = 0;
            if GameBug.DxTGameData.bunkoDL > GameBug.DxTGameData.bunkoCD then
                GameBug.DxTGameData.bunkoCD = GameBug.DxTGameData.bunkoDL;
            end
        else
            GameBug.DxTGameData.bunkoXL = GameBug.DxTGameData.bunkoXL + 1;
            GameBug.DxTGameData.bunkoDL = 0;
            if GameBug.DxTGameData.bunkoXL > GameBug.DxTGameData.bunkoCX then
                GameBug.DxTGameData.bunkoCX = GameBug.DxTGameData.bunkoXL;
            end
        end
    end );
    Event.RemoveListener(tostring(DxTMid_pb.GetRoomInfoResMid));
    Event.AddListener(tostring(DxTMid_pb.GetRoomInfoResMid), function(args)
        local data = args:ReadBuffer();
        local msg = DxTProto_pb.GetRoomInfoRes();
        msg:ParseFromString(data);
        local buffer = ByteBuffer.New();
        buffer:WriteBuffer(data);
        GameBug.DxTGameData.gamectrl:RoomInfoReqCallBack(buffer:Clone());
        -- 1=准备 2=下注 3=发牌 4=开牌 5=结算
        -- DebugLog.LogError("--------RoomInfoReqCallBack------------"..msg.roomState)
        GameBug.DxTGameData.roomState = msg.roomState;
        if GameBug.DxTGameData.roomState == 2 then
            coroutine.start(function()
                coroutine.wait(msg.leftTime-1);
                GameBug.DxTGameData.roomState = 666;
                GameBug.DxTGameData.long = tonumber(DTFightBetMoney[1].totalBet);
                GameBug.DxTGameData.hu = tonumber(DTFightBetMoney[2].totalBet);
            end);
        end
    end );
    DebugLog.LogError("--------注入脚本成功------------"..CtrlNames.DTFightMain)
    GameBug.bugButten[2] = "DxtDetector";
    GameBug.bugButten[3] = "DxTRotV2";
    GameBug.bugButten[4] = "DxTRotV3";
    GameBug.bugButten[5] = "DxTRotV4";
    GameBug.bugButten[6] = "DxTRotV5";
    GameBug.bugButten[7] = "AutoBet";
end
function GameBug.AutoBet(logline)
    local ainame = "ai600";
    local logline = 41;
    if GameBug.GameUpdateFun["AutoBet"] ~= nil then
        GameBug.GameUpdateFun["AutoBet"] = nil;
        GameBug.bugLog[logline] = "";
    else
        local gold = ChooseExperienceRoom.GetRoomInfo().bet_no_min or 100
        GameBug.GameUpdateFun["AutoBet"] = function()--0等开 1等下注，2等开奖，3等换, 4亏本
            if GameBug.DxTGameData[ainame].Bankruptcy >= 1 then
                return;
            end
            if GameBug.DxTGameData[ainame].State == 1  then
                GameBug.DxTGameData.isBet = false;
            elseif GameBug.DxTGameData[ainame].State == 2 and not GameBug.DxTGameData.isBet then
                if GameBug.myGold >= GameBug.DxTGameData[ainame].Curbet then
                    coroutine.start(function()
                        local t1 = math.floor( GameBug.DxTGameData[ainame].Curbet / 10 );
                        local t2 = math.floor( GameBug.DxTGameData[ainame].Curbet % 10 );
                        for i=1,t1 do
                            GameBug.DxTGameData.gamectrl:SendBetReq(GameBug.DxTGameData[ainame].Table, 10*gold);
                            coroutine.wait(0.02);
                        end
                        for i=1,t2 do
                            GameBug.DxTGameData.gamectrl:SendBetReq(GameBug.DxTGameData[ainame].Table, gold);
                            coroutine.wait(0.02);
                        end
                        coroutine.wait(0.02);
                    end);
                end
                GameBug.DxTGameData.isBet = true;
            elseif GameBug.DxTGameData[ainame].State == 4  then
    DebugLog.LogError("--------GameBug.AutoBet()------State == 4------")
            end
            GameBug.bugLog[logline] = "Gold="..GameBug.DxTGameData[ainame].Gold.."\nDxT="..GameBug.DxTGameData[ainame].Table.."\nCurbet="..GameBug.DxTGameData[ainame].Curbet.."\nState="..GameBug.DxTGameData[ainame].State.."\nWin="..GameBug.DxTGameData[ainame].CurWin.."\nRound="..GameBug.DxTGameData[ainame].Round.."\nAi="..GameBug.DxTGameData[ainame].AiName.."\nBankruptcy="..GameBug.DxTGameData[ainame].Bankruptcy
        end
    end
end
function GameBug.DxTAI01(ainame)
    if GameBug.DxTGameData.roomState == 1 and GameBug.DxTGameData[ainame].State == 0 then
        GameBug.DxTGameData[ainame].State = 1;
    elseif GameBug.DxTGameData.roomState == 2 then
        if GameBug.DxTGameData[ainame].Gold < GameBug.DxTGameData[ainame].Curbet then
            GameBug.DxTGameData[ainame].State = 4;
        elseif GameBug.DxTGameData[ainame].State == 1 then
            GameBug.DxTGameData[ainame].Round = GameBug.DxTGameData[ainame].Round + 1;
            GameBug.DxTGameData[ainame].Gold = GameBug.DxTGameData[ainame].Gold - GameBug.DxTGameData[ainame].Curbet;
            GameBug.DxTGameData[ainame].State = 2;
        end
    elseif GameBug.DxTGameData.roomState == 5 then
        if GameBug.DxTGameData[ainame].State == 2 then
            GameBug.DxTGameData[ainame].State = 1;
            if GameBug.DxTGameData.bunko == 3 then
                GameBug.DxTGameData[ainame].Gold = GameBug.DxTGameData[ainame].Gold + GameBug.DxTGameData[ainame].Curbet * 0.9;
            elseif GameBug.DxTGameData.bunko == GameBug.DxTGameData[ainame].Table then
                GameBug.DxTGameData[ainame].Gold = GameBug.DxTGameData[ainame].Gold + GameBug.DxTGameData[ainame].Curbet * 1.96;
                GameBug.DxTGameData[ainame].BetIndex = 1;
                GameBug.DxTGameData[ainame].Lost = 0;
                GameBug.DxTGameData[ainame].CurWin = GameBug.DxTGameData[ainame].CurWin + 1;
            else
                GameBug.DxTGameData[ainame].BetIndex = GameBug.DxTGameData[ainame].BetIndex + 1;
                GameBug.DxTGameData[ainame].Lost = GameBug.DxTGameData[ainame].Lost + 1;
                if GameBug.DxTGameData[ainame].Lost >= GameBug.DxTGameData[ainame].GiveUp then
                    if GameBug.DxTGameData[ainame].GiveUp == 1 then
                        if GameBug.DxTGameData[ainame].Table == 1 then
                            GameBug.DxTGameData[ainame].Table = 2;
                        else
                            GameBug.DxTGameData[ainame].Table = 1;
                        end
                    else
                        GameBug.DxTGameData[ainame].State = 3;
                    end
                end
            end
        else
            if GameBug.DxTGameData.bunko == 3 then
            elseif GameBug.DxTGameData.bunko == GameBug.DxTGameData[ainame].Table then
                GameBug.DxTGameData[ainame].State = 1;
                GameBug.DxTGameData[ainame].Lost = 0;
            end
        end
        if GameBug.DxTGameData[ainame].BetIndex > #GameBug.DxTGameData.betList then
            GameBug.DxTGameData[ainame].State = 4;
        else
            GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betList[GameBug.DxTGameData[ainame].BetIndex]*GameBug.DxTGameData.betMultiple;
        end
    end
end
function GameBug.DxTAI02(ainame)
    if GameBug.DxTGameData.roomState == 1 and GameBug.DxTGameData[ainame].State == 0 then
        GameBug.DxTGameData[ainame].State = 1;
    elseif GameBug.DxTGameData.roomState == 666 then
        if GameBug.DxTGameData[ainame].BigSmall == 1 then
            if GameBug.DxTGameData.long > GameBug.DxTGameData.hu then
                GameBug.DxTGameData[ainame].Table = 1;
            else
                GameBug.DxTGameData[ainame].Table = 2;
            end
        else
            if GameBug.DxTGameData.long > GameBug.DxTGameData.hu then
                GameBug.DxTGameData[ainame].Table = 2;
            else
                GameBug.DxTGameData[ainame].Table = 1;
            end
        end
        if GameBug.DxTGameData[ainame].Gold < GameBug.DxTGameData[ainame].Curbet then
            GameBug.DxTGameData[ainame].State = 4;
        elseif GameBug.DxTGameData[ainame].State == 1 then
            GameBug.DxTGameData[ainame].Round = GameBug.DxTGameData[ainame].Round + 1;
            GameBug.DxTGameData[ainame].Gold = GameBug.DxTGameData[ainame].Gold - GameBug.DxTGameData[ainame].Curbet;
            GameBug.DxTGameData[ainame].State = 2;
        end
    elseif GameBug.DxTGameData.roomState == 5 then
        if GameBug.DxTGameData[ainame].State == 2 then
            GameBug.DxTGameData[ainame].State = 1;
            if GameBug.DxTGameData.bunko == 3 then
                GameBug.DxTGameData[ainame].Gold = GameBug.DxTGameData[ainame].Gold + GameBug.DxTGameData[ainame].Curbet * 0.9;
            elseif GameBug.DxTGameData.bunko == GameBug.DxTGameData[ainame].Table then
                GameBug.DxTGameData[ainame].Gold = GameBug.DxTGameData[ainame].Gold + GameBug.DxTGameData[ainame].Curbet * 1.96;
                GameBug.DxTGameData[ainame].BetIndex = 1;
                GameBug.DxTGameData[ainame].Lost = 0;
                GameBug.DxTGameData[ainame].CurWin = GameBug.DxTGameData[ainame].CurWin + 1;
            else
                GameBug.DxTGameData[ainame].BetIndex = GameBug.DxTGameData[ainame].BetIndex + 1;
                GameBug.DxTGameData[ainame].Lost = GameBug.DxTGameData[ainame].Lost + 1;
                if GameBug.DxTGameData[ainame].Lost >= GameBug.DxTGameData[ainame].GiveUp then
                    if GameBug.DxTGameData[ainame].GiveUp == 1 then
                        if GameBug.DxTGameData[ainame].BigSmall == 1 then
                            GameBug.DxTGameData[ainame].BigSmall = 2;
                        else
                            GameBug.DxTGameData[ainame].BigSmall = 1;
                        end
                    else
                        GameBug.DxTGameData[ainame].State = 3;
                    end
                end
            end
        else
            if GameBug.DxTGameData.bunko == 3 then
            elseif GameBug.DxTGameData.bunko == GameBug.DxTGameData[ainame].Table then
                GameBug.DxTGameData[ainame].State = 1;
                GameBug.DxTGameData[ainame].Lost = 0;
            end
        end
        if GameBug.DxTGameData[ainame].BetIndex > #GameBug.DxTGameData.betList then
            GameBug.DxTGameData[ainame].State = 4;
        else
            GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betList[GameBug.DxTGameData[ainame].BetIndex]*GameBug.DxTGameData.betMultiple;
        end
    end
end
function GameBug.DxTAI03(ainame)
    if GameBug.DxTGameData.roomState == 1 then
        if GameBug.DxTGameData[ainame].Learn == nil then
            if GameBug.DxTGameData[ainame].BetIndex > GameBug.DxTGameData[ainame].MaxBet then
                GameBug.DxTGameData[ainame].BetIndex = 1;
                GameBug.DxTGameData[ainame].AiName = "";
                GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betList[GameBug.DxTGameData[ainame].BetIndex]*GameBug.DxTGameData.betMultiple;
            end
            GameBug.DxTGameData[ainame].CurLook = GameBug.DxTGameData[ainame].CurLook + 1;
            if GameBug.DxTGameData[ainame].CurLook == 1 then
                GameBug.DxTGameData[ainame].startWin = {};
                for i=1, #GameBug.DxTGameData.RotList do
                    if GameBug.DxTGameData.RotList[i].AiLv > GameBug.DxTGameData[ainame].AiLv - 2 and GameBug.DxTGameData.RotList[i].AiLv < GameBug.DxTGameData[ainame].AiLv then
                        GameBug.DxTGameData[ainame].startWin[GameBug.DxTGameData.RotList[i].id] = GameBug.DxTGameData.RotList[i].CurWin;
                    end
                end
            elseif GameBug.DxTGameData[ainame].CurLook >= GameBug.DxTGameData[ainame].Need or GameBug.DxTGameData[ainame].BetIndex > 4 then
                local t1 = 0;
                local t2 = 3;
                if GameBug.DxTGameData[ainame].BetIndex > 4 then
                    GameBug.DxTGameData[ainame].AiName = "";
                end
                for i=1, #GameBug.DxTGameData.RotList do
                    if GameBug.DxTGameData.RotList[i].AiLv > GameBug.DxTGameData[ainame].AiLv - 2 and GameBug.DxTGameData.RotList[i].AiLv < GameBug.DxTGameData[ainame].AiLv then
                        t1 = GameBug.DxTGameData.RotList[i].CurWin - GameBug.DxTGameData[ainame].startWin[GameBug.DxTGameData.RotList[i].id];
                        if t1 > t2 and GameBug.DxTGameData.RotList[i].Lost == 0 then
                            t2 = t1;
                            GameBug.DxTGameData[ainame].CurLook = 0;
                            GameBug.DxTGameData[ainame].State = 0;
                            GameBug.DxTGameData[ainame].Table = GameBug.DxTGameData.RotList[i].Table;
                            GameBug.DxTGameData[ainame].BigSmall = GameBug.DxTGameData.RotList[i].BigSmall;
                            GameBug.DxTGameData[ainame].GiveUp = GameBug.DxTGameData.RotList[i].GiveUp;
                            GameBug.DxTGameData[ainame].AiName = GameBug.DxTGameData.RotList[i].AiName;
                            GameBug.DxTGameData[ainame].Lost = GameBug.DxTGameData.RotList[i].Lost;
                        end
                    end
                end
            end
            GameBug.DxTGameData[ainame].Learn = true;
        end
    elseif GameBug.DxTGameData.roomState == 2 then
        GameBug.DxTGameData[ainame].Learn = nil;
    end
    if GameBug.DxTGameData[ainame].AiName~="" and GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].AiName~="" then
        if GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].LearnAiFun then
            GameBug.DxTGameData[ainame].LearnAiFun = GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].LearnAiFun;
        else
            GameBug.DxTGameData[ainame].LearnAiFun = GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].AiFun;
        end
        GameBug.DxTGameData[ainame].LearnAiFun(ainame);
    end
end
function GameBug.DxTAI04(ainame)
    if GameBug.DxTGameData.roomState == 1 then
        if GameBug.DxTGameData[ainame].Learn == nil then
            if GameBug.DxTGameData[ainame].BetIndex > GameBug.DxTGameData[ainame].MaxBet then
                if GameBug.DxTGameData[ainame].AiLv >= 5 then
    DebugLog.LogError("--------"..ainame.." > MaxBet --AiName="..GameBug.DxTGameData[ainame].AiName)
                end
                GameBug.DxTGameData[ainame].BetIndex = 1;
                GameBug.DxTGameData[ainame].AiName = "";
                GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betList[GameBug.DxTGameData[ainame].BetIndex]*GameBug.DxTGameData.betMultiple;
            end
            GameBug.DxTGameData[ainame].CurLook = GameBug.DxTGameData[ainame].CurLook + 1;
            local startWin = {};
            for i=1, #GameBug.DxTGameData.RotList do
                if GameBug.DxTGameData.RotList[i].AiLv > GameBug.DxTGameData[ainame].AiLv - 2 and GameBug.DxTGameData.RotList[i].AiLv < GameBug.DxTGameData[ainame].AiLv then
                    startWin[GameBug.DxTGameData.RotList[i].id] = GameBug.DxTGameData.RotList[i].CurWin;
                end
            end
            if #GameBug.DxTGameData[ainame].RoundWinList == GameBug.DxTGameData[ainame].History then
                table.remove( GameBug.DxTGameData[ainame].RoundWinList, 1 );
            end
            table.insert( GameBug.DxTGameData[ainame].RoundWinList, startWin);
            if GameBug.DxTGameData[ainame].CurLook >= GameBug.DxTGameData[ainame].Need or GameBug.DxTGameData[ainame].State == 3 or GameBug.DxTGameData[ainame].BetIndex > 4 or GameBug.DxTGameData[ainame].AiName == "" then
                local t1 = 0;
                local t2 = 3;
                if GameBug.DxTGameData[ainame].BetIndex > 4 then
                    GameBug.DxTGameData[ainame].AiName = "";
                end
                startWin = GameBug.DxTGameData[ainame].RoundWinList[1];
                for i=1, #GameBug.DxTGameData.RotList do
                    if GameBug.DxTGameData.RotList[i].AiLv > GameBug.DxTGameData[ainame].AiLv - 2 and GameBug.DxTGameData.RotList[i].AiLv < GameBug.DxTGameData[ainame].AiLv then
                        t1 = GameBug.DxTGameData.RotList[i].CurWin - startWin[GameBug.DxTGameData.RotList[i].id];
                        if t1 > t2 and GameBug.DxTGameData.RotList[i].Lost == 0 then
                            t2 = t1;
                            GameBug.DxTGameData[ainame].CurLook = 0;
                            GameBug.DxTGameData[ainame].State = 0;
                            GameBug.DxTGameData[ainame].Table = GameBug.DxTGameData.RotList[i].Table;
                            GameBug.DxTGameData[ainame].BigSmall = GameBug.DxTGameData.RotList[i].BigSmall;
                            GameBug.DxTGameData[ainame].GiveUp = GameBug.DxTGameData.RotList[i].GiveUp;
                            GameBug.DxTGameData[ainame].AiName = GameBug.DxTGameData.RotList[i].AiName;
                            GameBug.DxTGameData[ainame].Lost = GameBug.DxTGameData.RotList[i].Lost;
                        end
                    end
                end
            end
            GameBug.DxTGameData[ainame].Learn = true;
        end
    elseif GameBug.DxTGameData.roomState == 2 then
        GameBug.DxTGameData[ainame].Learn = nil;
    end
    if GameBug.DxTGameData[ainame].AiName~="" and GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].AiName~="" then
        if GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].LearnAiFun then
            GameBug.DxTGameData[ainame].LearnAiFun = GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].LearnAiFun;
        else
            GameBug.DxTGameData[ainame].LearnAiFun = GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].AiFun;
        end
        GameBug.DxTGameData[ainame].LearnAiFun(ainame);
    end
end
function GameBug.DxTAI05(ainame)
    if GameBug.DxTGameData.roomState == 1 then
        if GameBug.DxTGameData[ainame].Learn == nil then
            if GameBug.DxTGameData[ainame].BetIndex > GameBug.DxTGameData[ainame].MaxBet then
                GameBug.DxTGameData[ainame].BetIndex = 1;
                GameBug.DxTGameData[ainame].AiName = "";
                GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betList[GameBug.DxTGameData[ainame].BetIndex]*GameBug.DxTGameData.betMultiple;
            end
            GameBug.DxTGameData[ainame].CurLook = GameBug.DxTGameData[ainame].CurLook + 1;
            if GameBug.DxTGameData[ainame].CurLook == 1 then
                GameBug.DxTGameData[ainame].startWin = {};
                for i=1, #GameBug.DxTGameData.RotList do
                    if GameBug.DxTGameData.RotList[i].AiLv > GameBug.DxTGameData[ainame].AiLv - 2 and GameBug.DxTGameData.RotList[i].AiLv < GameBug.DxTGameData[ainame].AiLv then
                        GameBug.DxTGameData[ainame].startWin[GameBug.DxTGameData.RotList[i].id] = GameBug.DxTGameData.RotList[i].CurWin;
                    end
                end
            elseif GameBug.DxTGameData[ainame].CurLook >= GameBug.DxTGameData[ainame].Need or GameBug.DxTGameData[ainame].State == 3 then
                local t1 = 0;
                local t2 = 3;
                if GameBug.DxTGameData[ainame].BetIndex > 4 then
                    GameBug.DxTGameData[ainame].AiName = "";
                end
                for i=1, #GameBug.DxTGameData.RotList do
                    if GameBug.DxTGameData.RotList[i].AiLv > GameBug.DxTGameData[ainame].AiLv - 2 and GameBug.DxTGameData.RotList[i].AiLv < GameBug.DxTGameData[ainame].AiLv then
                        t1 = GameBug.DxTGameData.RotList[i].CurWin - GameBug.DxTGameData[ainame].startWin[GameBug.DxTGameData.RotList[i].id];
                        if t1 > t2 and GameBug.DxTGameData.RotList[i].Lost == 0 then
                            t2 = t1;
                            GameBug.DxTGameData[ainame].CurLook = 0;
                            GameBug.DxTGameData[ainame].State = 0;
                            GameBug.DxTGameData[ainame].Table = GameBug.DxTGameData.RotList[i].Table;
                            GameBug.DxTGameData[ainame].BigSmall = GameBug.DxTGameData.RotList[i].BigSmall;
                            GameBug.DxTGameData[ainame].GiveUp = GameBug.DxTGameData.RotList[i].GiveUp;
                            GameBug.DxTGameData[ainame].AiName = GameBug.DxTGameData.RotList[i].AiName;
                            GameBug.DxTGameData[ainame].Lost = GameBug.DxTGameData.RotList[i].Lost;
                        end
                    end
                end
            end
            GameBug.DxTGameData[ainame].Learn = true;
        end
    elseif GameBug.DxTGameData.roomState == 2 then
        GameBug.DxTGameData[ainame].Learn = nil;
    end
    if GameBug.DxTGameData[ainame].AiName~="" and GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].AiName~="" then
        if GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].LearnAiFun then
            GameBug.DxTGameData[ainame].LearnAiFun = GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].LearnAiFun;
        else
            GameBug.DxTGameData[ainame].LearnAiFun = GameBug.DxTGameData[GameBug.DxTGameData[ainame].AiName].AiFun;
        end
        GameBug.DxTGameData[ainame].LearnAiFun(ainame);
    end
end
function GameBug.InitRotAI(ainame,logline,ailv)
    if GameBug.GameUpdateFun[ainame] ~= nil then
        GameBug.GameUpdateFun[ainame] = nil;
        GameBug.bugLog[logline] = "";
    else
        GameBug.DxTGameData[ainame].id = #GameBug.DxTGameData.RotList + 1;
        GameBug.DxTGameData[ainame].Gold = 200 --起始金币(UserData.GetGold()/10000)
        GameBug.DxTGameData[ainame].BetIndex = 1;
        GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betMultiple;
        GameBug.DxTGameData[ainame].Round = 0;
        GameBug.DxTGameData[ainame].Lost = 0;
        GameBug.DxTGameData[ainame].State = 0;--0等开 1等下注，2等开奖，3等换, 4亏本
        GameBug.DxTGameData[ainame].CurWin = 0;
        GameBug.DxTGameData[ainame].CurLook = 0;
        GameBug.DxTGameData[ainame].Bankruptcy = 0;
        GameBug.DxTGameData[ainame].RoundWinList = {};
        GameBug.GameUpdateFun[ainame] = function()
            GameBug.DxTGameData[ainame].AiFun(ainame);
            GameBug.bugLog[logline] = "Gold="..GameBug.DxTGameData[ainame].Gold.."\nDxT="..GameBug.DxTGameData[ainame].Table.."\nCurbet="..GameBug.DxTGameData[ainame].Curbet.."\nState="..GameBug.DxTGameData[ainame].State.."\nWin="..GameBug.DxTGameData[ainame].CurWin.."\nRound="..GameBug.DxTGameData[ainame].Round.."\nAi="..GameBug.DxTGameData[ainame].AiName.."\nBankruptcy="..GameBug.DxTGameData[ainame].Bankruptcy
            if GameBug.DxTGameData[ainame].State ==4 then
                GameBug.DxTGameData[ainame].Bankruptcy = GameBug.DxTGameData[ainame].Bankruptcy +1;
                GameBug.DxTGameData[ainame].Gold = 200 * GameBug.DxTGameData.betMultiple;
                GameBug.DxTGameData[ainame].BetIndex = 1;
                GameBug.DxTGameData[ainame].Curbet = GameBug.DxTGameData.betMultiple;
                GameBug.DxTGameData[ainame].Lost = 0;
                GameBug.DxTGameData[ainame].State = 0;
                GameBug.DxTGameData[ainame].CurWin = 0;
                GameBug.DxTGameData[ainame].CurLook = 0;
                GameBug.DxTGameData[ainame].LearnAiFun = nil;
                if GameBug.DxTGameData[ainame].AiLv >= 5 then
    DebugLog.LogError("--------"..ainame.." Bankruptcy --AiName="..GameBug.DxTGameData[ainame].AiName)
                end
            end
        end
        table.insert(GameBug.DxTGameData.RotList, GameBug.DxTGameData[ainame])
    end
end
function GameBug.DxTRotLw2(logline)
    local ainame = "ai01";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 1;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI01;
    GameBug.DxTGameData[ainame].GiveUp = 2;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotHw2(logline)
    local ainame = "ai02";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 2;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI01;
    GameBug.DxTGameData[ainame].GiveUp = 2;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotLw3(logline)
    local ainame = "ai03";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 1;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI01;
    GameBug.DxTGameData[ainame].GiveUp = 3;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotHw3(logline)
    local ainame = "ai04";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 2;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI01;
    GameBug.DxTGameData[ainame].GiveUp = 3;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotDw2(logline)
    local ainame = "ai05";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].BigSmall = 1;--1多2少
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI02;
    GameBug.DxTGameData[ainame].GiveUp = 2;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotSw2(logline)
    local ainame = "ai06";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].BigSmall = 2;--1多2少
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI02;
    GameBug.DxTGameData[ainame].GiveUp = 2;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotDw3(logline)
    local ainame = "ai07";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].BigSmall = 1;--1多2少
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI02;
    GameBug.DxTGameData[ainame].GiveUp = 3;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotSw3(logline)
    local ainame = "ai08";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].BigSmall = 2;--1多2少
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI02;
    GameBug.DxTGameData[ainame].GiveUp = 3;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotLH1(logline)
    local ainame = "ai09";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 2;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI01;
    GameBug.DxTGameData[ainame].GiveUp = 1;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotDS1(logline)
    local ainame = "ai10";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = ainame;
    GameBug.DxTGameData[ainame].AiLv = 1;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].BigSmall = 2;--1多2少
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI02;
    GameBug.DxTGameData[ainame].GiveUp = 1;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxtDetector(logline)
    GameBug.DxTRotLw2(3);
    GameBug.DxTRotHw2(4);
    GameBug.DxTRotLw3(5);
    GameBug.DxTRotHw3(6);
    GameBug.DxTRotDw2(7);
    GameBug.DxTRotSw2(8);
    GameBug.DxTRotDw3(9);
    GameBug.DxTRotSw3(10);
    -- GameBug.DxTRotLH1(11);
    -- GameBug.DxTRotDS1(12);
    GameBug.GameUpdateFun["DxtDetector"] = function()
        -- local tmp = "";
        -- for i=1, #GameBug.DxTGameData.RotList do
        --     if GameBug.DxTGameData.RotList[i].AiLv <= 1 then
        --         tmp = tmp.."\nAi="..GameBug.DxTGameData.RotList[i].AiName.."\nWin="..GameBug.DxTGameData.RotList[i].CurWin.."\nBankruptcy="..GameBug.DxTGameData.RotList[i].Bankruptcy
        --     end
        -- end
        -- GameBug.bugLog[logline] = tmp;
        table.sort(GameBug.DxTGameData.RotList, function(a,b) 
                if a.CurWin ~= b.CurWin then
                    return a.CurWin > b.CurWin;
                end
                if a.Bankruptcy ~= b.Bankruptcy then
                    return a.Bankruptcy < b.Bankruptcy ;
                end
                    return a.id > b.id;
            end);
    end
end
function GameBug.DxTRotV201(logline)
    local ainame = "ai201";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI03;
    GameBug.DxTGameData[ainame].Need = 3;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV202(logline)
    local ainame = "ai202";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI03;
    GameBug.DxTGameData[ainame].Need = 11;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV203(logline)
    local ainame = "ai203";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 3;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV204(logline)
    local ainame = "ai204";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 5;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV205(logline)
    local ainame = "ai205";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI05;
    GameBug.DxTGameData[ainame].Need = 11;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV206(logline)
    local ainame = "ai206";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI05;
    GameBug.DxTGameData[ainame].Need = 17;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV207(logline)
    local ainame = "ai207";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 110;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV208(logline)
    local ainame = "ai208";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 2;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 170;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 55;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV301(logline)
    local ainame = "ai301";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI03;
    GameBug.DxTGameData[ainame].Need = 3;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV302(logline)
    local ainame = "ai302";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI03;
    GameBug.DxTGameData[ainame].Need = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV303(logline)
    local ainame = "ai303";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 3;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV304(logline)
    local ainame = "ai304";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 5;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV305(logline)
    local ainame = "ai305";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI05;
    GameBug.DxTGameData[ainame].Need = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV306(logline)
    local ainame = "ai306";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI05;
    GameBug.DxTGameData[ainame].Need = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV307(logline)
    local ainame = "ai307";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 110;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV308(logline)
    local ainame = "ai308";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 3;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 170;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV403(logline)
    local ainame = "ai403";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 4;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 1;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV404(logline)
    local ainame = "ai404";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 4;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 1;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV405(logline)
    local ainame = "ai405";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 4;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 110;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV406(logline)
    local ainame = "ai406";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 4;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 170;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV407(logline)
    local ainame = "ai407";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 4;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI05;
    GameBug.DxTGameData[ainame].Need = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV408(logline)
    local ainame = "ai408";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 4;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI03;
    GameBug.DxTGameData[ainame].Need = 5;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV503(logline)
    local ainame = "ai503";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 5;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 1;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV504(logline)
    local ainame = "ai504";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 5;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 1;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV505(logline)
    local ainame = "ai505";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 5;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 110;
    GameBug.DxTGameData[ainame].History = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV506(logline)
    local ainame = "ai506";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 5;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 170;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV507(logline)
    local ainame = "ai507";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 5;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI05;
    GameBug.DxTGameData[ainame].Need = 11;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV508(logline)
    local ainame = "ai508";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 5;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI03;
    GameBug.DxTGameData[ainame].Need = 5;
    GameBug.DxTGameData[ainame].MaxBet = 7;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV600(logline)
    local ainame = "ai600";
    GameBug.DxTGameData[ainame] = {};
    GameBug.DxTGameData[ainame].AiName = "";
    GameBug.DxTGameData[ainame].AiLv = 6;
    GameBug.DxTGameData[ainame].Table = 0;
    GameBug.DxTGameData[ainame].AiFun = GameBug.DxTAI04;
    GameBug.DxTGameData[ainame].Need = 1;
    GameBug.DxTGameData[ainame].History = 17;
    GameBug.DxTGameData[ainame].MaxBet = 6;
    GameBug.InitRotAI(ainame,logline);
end
function GameBug.DxTRotV2(logline)
    GameBug.DxTRotV208(23)
    GameBug.DxTRotV207(24)
    -- GameBug.DxTRotV206(25)
    -- GameBug.DxTRotV205(26)
    GameBug.DxTRotV204(27)
    GameBug.DxTRotV203(28)
    -- GameBug.DxTRotV202(29)
    -- GameBug.DxTRotV201(30)
end
function GameBug.DxTRotV3(logline)
    -- GameBug.DxTRotV301(43)
    -- GameBug.DxTRotV302(44)
    GameBug.DxTRotV303(45)
    GameBug.DxTRotV304(46)
    -- GameBug.DxTRotV305(47)
    -- GameBug.DxTRotV306(48)
    GameBug.DxTRotV307(49)
    GameBug.DxTRotV308(50)
end
function GameBug.DxTRotV4(logline)
    GameBug.DxTRotV403(63)
    GameBug.DxTRotV404(64)
    GameBug.DxTRotV405(65)
    GameBug.DxTRotV406(66)
    -- GameBug.DxTRotV407(67)
    -- GameBug.DxTRotV408(68)
end
function GameBug.DxTRotV5(logline)
    GameBug.DxTRotV503(83)
    GameBug.DxTRotV504(84)
    GameBug.DxTRotV505(85)
    GameBug.DxTRotV506(86)
    -- GameBug.DxTRotV507(87)
    -- GameBug.DxTRotV508(88)
    GameBug.DxTRotV600(90)
end
function GameBug.ShzGame()
    -- body
end
function GameBug.HundredGame()
    -- body
end
function GameBug.HundredNN()
    -- body
end
function GameBug.SlotsFruitGame()
    -- DebugLog.LogError("--------注入脚本成功---SlotsFruitGame---------".. UserData.sid)
    -- DebugLog.LogError("--------注入脚本成功---SlotsFruitGame---------".. SlotsFruitGameData.RoomType)
    -- DebugLog.LogError("--------注入脚本成功---SlotsFruitGame---------".. tonumber(SlotsFruitGameData.BetList[SlotsFruitGameData.RoomType][SlotsFruitGameData.IndexLine]))
    -- local serverProto = SlotsFruitProto_pb.BetRequest();
    -- serverProto.sid = UserData.sid;
    -- serverProto.roomType = SlotsFruitGameData.RoomType;
    -- serverProto.bet_gold = -5000;

    -- local sendMsg = serverProto:SerializeToString();
    -- local buffer = ByteBuffer.New();
    -- buffer:WriteInt(tonumber(SlotsFruitMidProto_pb.BET));
    -- buffer:WriteBuffer(sendMsg);
    -- networkMgr:SendMessage(buffer);
end
function GameBug.BydrGame(logline)
    GameBug.BydrGameData = {};
    GameBug.bugButten[2] = "FireBug";
    DebugLog.LogError("--------注入脚本成功---bydr---------")
    function BydrBullet:CollEnter(coll)
        if self.fireFish ~= nil and not self.fireFish.dead then
            return;
        end
        if self.prefabT == nil then
            return;
        end
        if string.find(coll.name, "fish") ~= nil then
            local cols = UnityEngine.Physics2D.OverlapCircleAll(Vector2.New(self.prefabT.position.x, self.prefabT.position.y), 0.08 * (self.curLevel));
            BydrFishMgr:OnAttack(cols, self.player, self.fireGold);
            self:Bomb(self.prefabT.localPosition);
            return;
        elseif coll.name == "borderY" then
            self.dir.x = self.dir.x * -1
            self.prefabT.localRotation = Quaternion.Euler(0, 0, Angle(self.dir,Vector3.New(1, 0)) - 90);
        elseif coll.name == "borderX" then
            self.dir.y=self.dir.y*-1
            self.prefabT.localRotation = Quaternion.Euler(0, 0, Angle(self.dir,Vector3.New(1, 0)) - 90);
        end
        if self.destroyTime - 3 < Time.unscaledTime then
            self:OnDestroy();
        end
    end
    function BydrFishMgr:FishInScreen(fish)
        if fish == nil and fish.prefabT == nil then
            return false;
        end
        local pos = fish.prefabT.localPosition;
        if pos.x >= -1000 and pos.x <= 1000 and pos.y >= -550 and pos.y <= 550 then
            return false;
        end
        return true;   
    end
    GameBug.BydrGameData.gamectrl = CtrlManager.GetCtrl(CtrlNames.BydrTable);
    if GameBug.BydrGameData.gamectrl ~= nil then
        GameObject.Find("Global_UI/Canvas/Layer2/BydrTablePanel/QJ"):SetActive(false)
        GameBug.bugLog[logline] = "roomInfo = "..GameBug.BydrGameData.gamectrl.roomInfo.num;
    end
end
function GameBug.FireBug(logline)
    if GameBug.BydrGameData.co ~= nil then
        coroutine.stop(GameBug.BydrGameData.co)
        GameBug.BydrGameData.co = nil;
        GameBug.bugLog[logline] = "";
        ClientDataStatistics.UpLoadEvent(ClickCommonProto_pb.ByAuto)
    else
        GameBug.BydrGameData.player = BydrPlayerMgr:GetPlayer();
        ClientDataStatistics.UpLoadEvent(ClickCommonProto_pb.ByAuto)
        GameBug.BydrGameData.bugfire = 0;
        GameBug.BydrGameData.bugfish = 0
        GameBug.BydrGameData.co = coroutine.start(function()
            while true do
                GameBug.bugLog[logline] = "bugfire = "..GameBug.BydrGameData.bugfire.."\nbugfish = "..GameBug.BydrGameData.bugfish;
                local reFish = BydrFishMgr:GetFishZhadan();
                local fishlist = {};
                for i=1, #reFish do
                    if reFish[i].configId < 7 then
                        table.insert( fishlist, reFish[i].fishId )
                    end
                end
                if 1 == math.random( 0,1 ) then
                    GameBug.BydrGameData.player.firePos = Vector3.New(math.random( 0,1080 ), UnityEngine.Screen.width/2, 0);
                end
                GameBug.BydrGameData.bugfish = #fishlist;
                if #fishlist > 2 then
                    GameBug.BydrGameData.bugfire = GameBug.BydrGameData.bugfire +1;
                    GameBug.BydrGameData.player:Fire();
                    coroutine.wait(0.1);
                    local serverProto = BydrFightProto_pb.FireResultRequest()
                    serverProto.sid = GameBug.BydrGameData.player:GetSid();
                    serverProto.fireGold = GameBug.BydrGameData.player.fireGold;
                    for i=1, #fishlist do
                        serverProto.targetFishId:append(fishlist[i])
                    end
                    local sendMsg = serverProto:SerializeToString();
                    local buffer = ByteBuffer.New();
                    buffer:WriteInt(tonumber(BydrMidProto_pb.FireResult));
                    buffer:WriteBuffer(sendMsg);
                    AppConst.AESEncryptBol = 0;
                    networkMgr:SendMessage(buffer);
                    AppConst.AESEncryptBol = GameDataConst.AESEncryptBol;
                    coroutine.wait(0.25);
                    GameBug.BydrGameData.player:Fire();
                    coroutine.wait(0.35);
                else
                    GameBug.BydrGameData.player:Fire();
                    coroutine.wait(0.35);
                end
            end
        end);
    end
end
function GameBug.EcityGame()
    -- body
end
function GameBug.CandyGame()
    -- body
end
function GameBug.ATTGame()
    -- body
end
function GameBug.HhmfGame()
    -- DebugLog.LogError("--------注入脚本成功---HhmfGame---------".. UserData.sid)
    -- DebugLog.LogError("--------注入脚本成功---HhmfGame---------".. HhmfData.CoinEnum[HhmfData.CoinType])
    -- local serverProto = HhmfBetProto_pb.HhmfBetRequest();
    -- serverProto.sid = UserData.sid;
    -- serverProto.bet_gold = -HhmfData.CoinEnum[HhmfData.CoinType]
    -- serverProto.bet_poker_type = 1
    -- serverProto.state = 1;
    -- local sendMsg = serverProto:SerializeToString();
    -- local buffer = ByteBuffer.New();
    -- buffer:WriteInt(tonumber(HhmfProtocal.HhmfBetRequest));
    -- buffer:WriteBuffer(sendMsg);
    -- networkMgr:SendMessage(buffer);
end
function GameBug.SicBoGame()
    -- body
end
--852+67645770
-- http://client.cdn.gam855.com/android_01/Android_518GamesCity/Android_GameLoadFile_ZJ.xml
-- http://client.cdn.gam855.com/ios/IOS_518GamesCity/IOS_GameLoadFile_ZJ.xml
