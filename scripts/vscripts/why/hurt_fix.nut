// 简易叠伤修复，用法：
//modify:
//{
//	match:
//	{
//		"classname" "trigger_hurt"
//		"targetname" "看情况要不要写"
//	}
//	insert:
//	{
//		"vscripts" "why/hurt_fix.nut"
//	}
//}
//注意事项：
//1、如果hurt实体本身有脚本会覆盖本身的脚本，请手动找出并改成replace
//2、高速移动的hurt该方式会导致hurt会慢一些到达，预计差距为 速度/32（由于速度快到的也会更快，大致理解成晚0.03秒左右到达），door的延迟似乎会更大
//3、每个hurt会对应多两个实体
if(self.GetClassname().slice(0,8)!="trigger_")return;
if(self.GetMoveParent()==null)return;

local hurtN=self.GetName();
if(hurtN==null){
	hurtN=UniqueString("bugdmgfix_hurt");
	self.__KeyValueFromString("targetname", hurtN);
}

target <- Entities.CreateByClassname("info_target");
local targetN=UniqueString("bugdmgfix_tar");
target.__KeyValueFromString("targetname", targetN);
target.SetOrigin(self.GetOrigin());
EntFireByHandle(target, "SetParent", self.GetMoveParent().GetName(), 0, null, null);

EntFireByHandle(self, "ClearParent", "", 0, null, null);

move <- Entities.CreateByClassname("logic_measure_movement");
move.__KeyValueFromFloat("TargetScale", 1.0);
move.__KeyValueFromInt("MeasureType", 0);
EntFireByHandle(move, "SetMeasureReference", targetN, 0, self, self);
EntFireByHandle(move, "SetTarget", hurtN, 0, self, self);
EntFireByHandle(move, "SetTargetReference", targetN, 0, self, self);
EntFireByHandle(move, "SetMeasureTarget", targetN, 0, self, self);
EntFireByHandle(move, "Enable", "", 0, self, self);
EntFireByHandle(move, "RunScriptFile", "why/base/checktokill.nut", 0.0, self, self);
EntFireByHandle(move, "RunScriptCode", "SaveKillEnt(\""+targetN+"\",\""+hurtN+"\")", 0.1, self, self);
