/*===============================================================================
|		                                                                        |
|	╭━╯  Powered by Bati  ╰━╮                                                   |
|	┏ Steam: https://steamcommunity.com/id/BATIns                               |
|	┃ Discord: Bati#0879                                                        |
|	┗ GitHub: https://github.com/00Bati                                	        |
|                                                                               |
|	                                                                            |
|	Plugin jest mojego autorstwa. Mozesz go modyfikowac/ rekonstruować.         | 
|	Ewentualne błędy mozesz zgłosić w wiadmosci prywatnej.                      |
|	Kompletny zakaz reselling'u/sprzedawania pluginu.                           |
|		                                                                        |
|		                                                                        |
===============================================================================*/

/*  [ DEFINES ]  */
#define Plugin_Name "[ ResetScore - Bati ] "
#define Plugin_Author "Bati"
#define Plugin_Desc "Plugin, ktory pozwala resetowac statystyki w tabeli"
#define Plugin_Version "Updated 1.1"
#define Plugin_Url "[ steam | id/BATIns ] "

#define PLUGIN_ICON "⠀⠀➤ {orange}"

/*  [ VARIABLES ]  */
g_PlayerCmdCoolDown[MAXPLAYERS];
PlayerCmdCoolDownReal = 15;

/*   [  I N C  ]   */
#include <multicolors>
#include <sourcemod>
#include <cstrike>

/*  >>| Wstepne ustawienia kompilacji |<<  */
#pragma semicolon 1
#pragma newdecls required


/*  [ AUTHOR INFO ] */
public Plugin myinfo = {
	name = Plugin_Name, 
	author = Plugin_Author, 
	description = Plugin_Desc, 
	version = Plugin_Version, 
	url = Plugin_Url
};

public void OnPluginStart() {
	RegConsoleCmd("sm_resetscore", Cmd_ResetScore);
	RegConsoleCmd("sm_resetuj", Cmd_ResetScore);
	RegConsoleCmd("sm_brs", Cmd_ResetScore);
	RegConsoleCmd("sm_rs", Cmd_ResetScore);
	
	ServerCommand("mp_backup_round_auto 0");
	LoadTranslations("Resetscore.phrases");
}

public void OnMapStart() {
	PrintToServer("  [ ResetScore ]  -}  Plugin zaladowany pomyslnie");
}

public Action Cmd_ResetScore(int iClient, int iArgs) {
	if (g_PlayerCmdCoolDown[iClient] < GetTime()) {
		g_PlayerCmdCoolDown[iClient] = GetTime() + PlayerCmdCoolDownReal;
		if (GetClientDeaths(iClient) || CS_GetClientContributionScore(iClient)) {
			SetEntProp(iClient, Prop_Data, "m_iDeaths", 0);
			SetEntProp(iClient, Prop_Data, "m_iFrags", 0);
			CS_SetClientContributionScore(iClient, 0);
			CS_SetClientAssists(iClient, 0);
			CS_SetMVPCount(iClient, 0);
			
			CPrintToChat(iClient, "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀{grey}» {orange}ResetScore {grey}«");
			CPrintToChat(iClient, " ");
			CPrintToChat(iClient, "%s %t!!!", PLUGIN_ICON, "Success Reset");
			CPrintToChat(iClient, " ");
			CPrintToChat(iClient, "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀{grey}» {orange}ResetScore {grey}«");
		} else {
			CPrintToChat(iClient, "{grey}%s {darkred}%t!!!", PLUGIN_ICON, "Danger Reset");
		}
	} else {
		CPrintToChat(iClient, "{grey}%s {lightgreen}Troche zwolnij!!!", PLUGIN_ICON);
		CPrintToChat(iClient, "{grey}%s {lightgreen}Troche zwolnij!!!", PLUGIN_ICON);
		CPrintToChat(iClient, "{grey}%s {lightgreen}Troche zwolnij!!!", PLUGIN_ICON);
	}
}
