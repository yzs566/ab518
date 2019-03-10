
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
        CtrlManager.Close(CtrlNames.WindowMask);
    else
        local mask = CtrlManager.Show(CtrlNames.WindowMask,4);
        local image = mask.transform:GetComponent("Image")
        image.color = Color.New(0, 0, 0, 0.6);
        image.raycastTarget = false;
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
