local C, F, L = unpack(select(2, ...))

local locale = GetLocale()
L.Text = {}
--locale = "zhTW"
--locale = "enUS"


--< zhCN >------------------------------------------------------

if locale == "zhCN" then
	L.Text['RELOAD_UI'] = '重载界面'
	L.Text['ON'] = '开启'
	L.Text['OFF'] = '关闭'
	L.Text['START'] = '开始'
	L.Text['OK'] = '确认'
	L.Text['MOVE_FRAME'] = '移动框体'
	L.Text['RESET_POSITION'] = '恢复默认位置'
	L.Text['AUTO_SCALE'] = '自动缩放'
	L.Text['PLAYER_FRAME'] = '玩家框体'
	L.Text['TARGET_FRAME'] = '目标框体'
	L.Text['BUFF_FRAME'] = 'Buff'
	L.Text['ACTIONBAR_FRAME'] = '动作条'
	L.Text['MINIMAP_FRAME'] = '小地图'
	
	
----------------------------------------------------------------



--< enUS >------------------------------------------------------

else


end

----------------------------------------------------------------