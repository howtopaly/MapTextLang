function rld()
{
	ScriptPrintMessageChatAll("koyo");
}

function st()
{
	self.__KeyValueFromString("message","          ⣠⣶⡾⠏⠉⠙⠳⢦⡀\n⠀⠀⠀⣴⠿⠏⠀⠀⠀ ⠀⠀⠀⢳⡀⠀\n⠀⠀⢠⣟⣋⡀⢀⣀⣀⡀⠀⣀⡀⣧  \n⠀⠀⢸⣯⡭⠁⠸⣛⣟⠆⡴⣻⡲⣿  \n⠀⠀⣟⣿⡭⠀⠀⠀⠀⠀⢱⠀⠀⣿⠀⢹⠀  \n⠀⠀⠙⢿⣯⠄⠀⠀⠀⢀⡀⠀⠀⡿⠀  \n⠀⠀⠀⠀⠹⣶⠆⠀⠀⠀⠀⠀⡴⠃⠀⠀\n⠀⠀⠀⠀⠀⢸⣷⡦⢤⡤⢤⣞⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀⠀⢀⣤⣴⣿⣏⠁⠀⠀⠸⣏⢯⣷⣖⣦⡀");
	self.__KeyValueFromString("targetname","qwe");
	self.__KeyValueFromString("color","105 255 105");
	self.__KeyValueFromFloat("y",0.2);
	self.__KeyValueFromFloat("x",0.4);
	self.__KeyValueFromFloat("fadein",1);
	self.__KeyValueFromFloat("fadeout",2);
	self.__KeyValueFromFloat("holdtime",5);
	self.__KeyValueFromFloat("fxtime",10);
	self.__KeyValueFromInt("spawnflags",0);
	self.__KeyValueFromInt("channel",3);
	EntFireByHandle(self,"Display","",0.01,activator,self);
}

self.ConnectOutput("onuser1","st");
