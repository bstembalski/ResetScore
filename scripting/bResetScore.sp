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


/* >>| DEFINE |<< */
#define PLUGIN_ICON "⠀⠀➤ {orange}"


/*  >>| Wstepne ustawienia kompilacji |<<  */
#pragma semicolon 1
#pragma newdecls required


/* >>| INC |<< */
#include <multicolors>
#include <sourcemod>
#include <cstrike>

/* >>| Autor/Plugin Info |<< */
public Plugin myinfo = {
	name = "ResetScore - Bati", 
	author = "Bati", 
	description = "ResetScore - Bati", 
	version = "1.0", 
	url = " "
};


/* >>| Plugin Code |<< */
public void OnPluginStart() {
	RegConsoleCmd("sm_rs", Cmd_ResetScore);
	RegConsoleCmd("sm_resetscore", Cmd_ResetScore);
	RegConsoleCmd("sm_resetuj", Cmd_ResetScore);
	
	ServerCommand("mp_backup_round_auto 0");
	
	LoadTranslations("ResetScore.phrases");
}

public Action Cmd_ResetScore(int iClient, int iArgs) {
	if (GetUserFlagBits(iClient)&ADMFLAG_CUSTOM1) {
		if (GetClientDeaths(iClient) || CS_GetClientContributionScore(iClient)) {
			CS_SetClientContributionScore(iClient, 0);
			CS_SetMVPCount(iClient, 0);
			CS_SetClientAssists(iClient, 0);
			SetEntProp(iClient, Prop_Data, "m_iFrags", 0);
			SetEntProp(iClient, Prop_Data, "m_iDeaths", 0);
			CPrintToChat(iClient, " ");
			CPrintToChat(iClient, "{orange}⌜⠀⠀⠀⠀⠀⠀⠀⠀{default}» {orange}ResetScore {default}«{orange}⠀⠀⠀⠀⠀⠀⠀⠀⌝");
			CPrintToChat(iClient, " ");
			CPrintToChat(iClient, "%s %t!!!", PLUGIN_ICON, "Success Reset");
			CPrintToChat(iClient, " ");
			CPrintToChat(iClient, "{orange}⌞⠀⠀⠀⠀⠀⠀⠀⠀{default}» {orange}ResetScore {default}«{orange}⠀⠀⠀⠀⠀⠀⠀⠀⌟");
		} else {
			CPrintToChat(iClient, " ");
			CPrintToChat(iClient, "%s %t!!!", PLUGIN_ICON, "Danger Reset");
			CPrintToChat(iClient, " ");
		}
	} else {
		CPrintToChat(iClient, " ");
		CPrintToChat(iClient, "%s %t!!!", PLUGIN_ICON, "Vip Permission");
		CPrintToChat(iClient, " ");
	}
} 
