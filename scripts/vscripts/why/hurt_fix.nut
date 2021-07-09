// 简易叠伤修复，用法：
//modify:
//{
//	match:
//	{
//		"classname" "trigger_hurt"
//		"targetname" "看情况要不要写，如果下面的情况不会有影响，也可以不写这里直接对所有hurt生效"
//	}
//	insert:
//	{
//		"vscripts" "why/hurt_fix.nut"
//	}
//}
//注意事项：
//0、如果trigger_hurt有多个同名实体，且parent对象并非template生成或勾了don't do namefix，会导致hurt移动异常(目前脚本禁用该情况，并提示)
//1、如果hurt实体本身有脚本会覆盖本身的脚本，请手动找出并改成replace
//2、高速移动的hurt该方式会导致hurt会慢一些到达，预计差距为 速度/32（由于速度快到的也会更快，大致理解成晚0.03秒左右到达），door的延迟似乎会更大
//3、每个hurt会对应多两个实体
if(self.GetClassname().slice(0,8)!="trigger_")return;
if(self.GetMoveParent()==null)return;

function checkInRepeat(name){
	if(Entities.FindByName(null, "load_script")==null){
		ent <- Entities.CreateByClassname("logic_relay");
		ent.__KeyValueFromString("targetname", "load_script");
	}
	ent <- Entities.FindByName(null, "load_script");
	printl(ent);
	if(!ent.ValidateScriptScope()){
		ScriptPrintMessageChatAll("脚本数据异常，停用叠伤修复");
		return;
	}
	if(!("NAME_REPEAT_LIST" in ent.GetScriptScope())){
		ent.GetScriptScope().NAME_REPEAT_LIST<-[];
	}
	foreach(k in ent.GetScriptScope().NAME_REPEAT_LIST){
		printl(k);
		if(k==name){
			printl(true);
			return true;
		}
	}
	ent.GetScriptScope().NAME_REPEAT_LIST.push(name);
	return false;
}

local ent=null;
while ((ent = Entities.FindByName(ent, self.GetMoveParent().GetName())) != null)
{
	if(ent!=self.GetMoveParent()){
		if(!checkInRepeat(self.GetMoveParent().GetName())){
			ScriptPrintMessageChatAll(" \x04重名parent，停用叠伤修复：\x02"+self.GetMoveParent().GetName());
		}
		return;
	}
	if(ent==null){
		break;
	}
}

local hurtN=self.GetName();
if(hurtN==""){
	hurtN=UniqueString("bugdmgfix_hurt");
	self.__KeyValueFromString("targetname", hurtN);
}else if(hurtN == self.GetPreTemplateName() && self.GetMoveParent().GetName() != self.GetMoveParent().GetPreTemplateName()){
	hurtN=hurtN+"&&"+self.GetMoveParent().GetName();
	self.__KeyValueFromString("targetname", hurtN);
}
ent=null;
while ((ent = Entities.FindByName(ent, hurtN)) != null)
{
	if(ent!=self){
		if(!checkInRepeat(hurtN)){
			ScriptPrintMessageChatAll(" \x04重名hurt，停用叠伤修复：\x02"+hurtN);
		}
		return;
	}
	if(ent==null){
		break;
	}
}
local oldVec=self.GetAngles();

target <- Entities.CreateByClassname("info_target");
local targetN=UniqueString("bugdmgfix_tar");
target.__KeyValueFromString("targetname", targetN);
target.SetOrigin(self.GetOrigin());
target.SetAngles(oldVec.x, oldVec.y, oldVec.z);
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
