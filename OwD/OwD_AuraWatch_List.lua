local C, F, L = unpack(select(2, ...))

--- ----------------------------------------------------------------------------
--> Aura Filter		
--- ----------------------------------------------------------------------------
--> {"ID", "TYPE", "COLOR", "ICON", "NAME", "ID_EXTRA"}
--> TYPE: P = Player, T = Target, S = Spell. 
--> localizedClass, englishClass, classIndex = UnitClass("unit")
--> classIndex: 
--> None = 0, Warrior = 1, Paladin = 2, Hunter = 3, Rogue = 4, Priest = 5, 
--> DeathKnight = 6, Shaman = 7, Mage = 8, Warlock = 9, Monk = 10, Druid = 11,
--- ----------------------------------------------------------------------------
L.AuraFilter = {}
	
L.AuraFilter["WARRIOR"] = {
	[1] = { --武器
		[1] = {
			
		},
		[2] = {
			
		},
	},
	[2] = { --狂怒
		[1] = {
			
		},
		[2] = {
			
		},
	},
	[3] = { --防护
		[1] = {
			
		},
		[2] = {
			
		},
	},
}

L.AuraFilter["PALADIN"] = {
	[1] = { --神圣
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[2] = { --惩戒
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = { --防护
		[1] = {
		
		},
		[2] = {
		
		},
	},
}

L.AuraFilter["HUNTER"] = {
	[1] = { --野兽控制
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[2] = { --射击
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = { --生存
		[1] = {
		
		},
		[2] = {
		
		},
	},
}

L.AuraFilter["ROGUE"] = {
	[1] = { --刺杀
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[2] = { --战斗
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = { --敏锐
		[1] = {
		
		},
		[2] = {
		
		},
	},
}

L.AuraFilter["PRIEST"] = {
	[1] = { --戒律
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[2] = { --神圣
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = { --暗影
		[1] = {
		
		},
		[2] = {
		
		},
	},
}

L.AuraFilter["DEATHKNIGHT"] = {
	[1] = { --鲜血
		[1] = {
			
		},
		[2] = {
		
		},
		
		
	},
	[2] = { --冰霜
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = { --邪恶
		[1] = {
		
		},
		[2] = {
		
		},
	},
}

L.AuraFilter["SHAMAN"] = {
	[1] = {
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[2] = {
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = {
		[1] = {
		
		},
		[2] = {
		
		},
	},
}

L.AuraFilter["MAGE"] = {
	[1] = { -->奥术
		[1] = {
			
		},
		[2] = {
			
		},
	},
	[2] = { -->火焰
		[1] = {
			
		},
		[2] = {
			
		},
	},
	[3] = { -->冰霜
		[1] = {
			
		},
		[2] = {
			
		},
	},
}

L.AuraFilter["WARLOCK"] = {
	[1] = { --痛苦
		[1] = {
			{Spell = "146739", Aura = "146739", Unit = "target", Icon = "JumpJet"         }, --腐蚀术
			{Spell = nil,      Aura = "980",    Unit = "target", Icon = "ShadowStep"      }, -->痛楚
			{Spell = nil,      Aura = "30108",  Unit = "target", Icon = "WraithForm"      }, --痛苦无常
			{Spell = nil,      Aura = "48181",  Unit = "target", Icon = "DeathBlossom"    }, --鬼影缠身
		},
		[2] = {
			{Spell = "113860", Aura = "113860", Unit = "player", Icon = "GuardianAngel"   }, --黑暗灵魂：哀难
		},
		[3] = {
			
		},
	},
	[2] = { --恶魔学识
		[1] = {
			{Spell = nil,      Aura = "47960", Unit = "target", Icon = "JumpJet"          }, --古尔丹之手
		},
		[2] = {
		
		},
		[3] = {
			
		},
	},
	[3] = { --毁灭
		[1] = {
			{Spell = nil,      Aura = "157736", Unit = "target", Icon = "JumpJet"         }, --献祭
			{Spell = nil,      Aura = "117828", Unit = "player", Icon = "Blink"           }, --爆燃
			{Spell = "17962",  Aura = nil,      Unit = nil,      Icon = "Flashbang"       }, --燃烧
			{Spell = "113858", Aura = "113858", Unit = "player", Icon = "GuardianAngel"   }, --黑暗灵魂：易爆
		},
		[2] = {
			{Spell = "120451", Aura = nil,      Unit = nil,      Icon = "Resurrect"       }, --克索诺斯之焰
		},
		[3] = {
			
		},
	},
}

L.AuraFilter["MONK"] = {
	[1] = {	--酒仙
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[2] = {	--织雾
		[1] = {
		
		},
		[2] = {
		
		},
	},
	[3] = {	--风行
		[1] = {
			{Spell = nil,      Aura = "125195", Unit = "player", Icon = "Blink"              }, --虎眼酒
			{Spell = "117418", Aura = nil,      Unit = nil,      Icon = "ScatterArrow"       }, --怒雷破
			{Spell = "107428", Aura = nil,      Unit = nil,      Icon = "JumpJet"            }, --旭日东升踢
			
		},
		[2] = {
			{Spell = nil,      Aura = "125359", Unit = "player", Icon = "GuardianAngel"      }, --猛虎之力
			{Spell = "116705", Aura = nil     , Unit = nil,      Icon = "FireStrike"         }, --切喉手
		},	
	},
}

L.AuraFilter["DRUID"] = {
	[1] = {	--平衡
		[1] = {
			{Spell = nil,      Aura = "164812", Unit = "target", Icon = "OrbofDiscord"       }, --月火术
			{Spell = nil,      Aura = "164815", Unit = "target", Icon = "OrbofHarmony"       }, --阳炎术
			{Spell = "112071", Aura = "112071", Unit = "Player", Icon = "ConcussiveBlast"    }, --超凡之盟
		},
		[2] = {
		
		},
	},
	[2] = {	--野性
		[1] = {
			{Spell = nil,      Aura = "155722", Unit = "target", Icon = "Flashbang"          }, --斜掠
			{Spell = nil,      Aura = "1079",   Unit = "target", Icon = "Recall"             }, --割裂
			{Spell = "5217",   Aura = "5217",   Unit = "player", Icon = "Blink"              }, --猛虎之怒
			{Spell = "106952", Aura = "106951", Unit = "player", Icon = "ConcussiveBlast"    }, --狂暴
		},
		[2] = {
			{Spell = "106839", Aura = nil,      Unit = nil,      Icon = "FireStrike"         }, --迎头痛击
			{Spell = nil,      Aura = "127538", Unit = "player", Icon = "GuardianAngel"      }, --野蛮咆哮
		},
	},
	[3] = {	--守护
		[1] = {
			{Spell = nil,      Aura = "77758",  Unit = "target", Icon = "ScatterArrow"       }, --痛击
			{Spell = "6807",   Aura = nil,      Unit = nil,      Icon = "SonicArrow"         }, --重殴
			{Spell = "33917",  Aura = nil,      Unit = nil,      Icon = "Recall"             }, --裂伤
			{Spell = "106952", Aura = "106951", Unit = "player", Icon = "ConcussiveBlast"    }, --狂暴
		},
		[1] = {
			{Spell = "106839", Aura = nil,      Unit = nil,      Icon = "FireStrike"         }, --迎头痛击
		},	
	},
	[4] = {	--恢复
		[1] = {
		
		},
		[1] = {
		
		},
	},
}