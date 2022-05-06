#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
	name			= "qCustomBomb",
	author			= "-_- (Karol Skupień)",
	description		= "Custom Bomb in game",
	version			= "1.0",
	url				= "https://github.com/Qesik"
};

public void OnMapStart(/*void*/) {
	AddFileToDownloadsTable("models/nico/models/prop/seasons/deco_snowman_sims4_seasonspack.mdl");
	AddFileToDownloadsTable("models/nico/models/prop/seasons/deco_snowman_sims4_seasonspack.vvd");
	AddFileToDownloadsTable("models/nico/models/prop/seasons/deco_snowman_sims4_seasonspack.dx90.vtx");

	AddFileToDownloadsTable("materials/models/nico/seasons/snowman1.vmt");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman1.vtf");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman2.vmt");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman2.vtf");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman3.vmt");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman3.vtf");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman4.vmt");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman4.vtf");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman5.vmt");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman5.vtf");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman6.vmt");
	AddFileToDownloadsTable("materials/models/nico/seasons/snowman6.vtf");
}

enum {
	BOMB,
	CHILDREN
}

enum struct BombData {
	char BombPath[PLATFORM_MAX_PATH];
	float BombScale;
	char ChildrenPath[PLATFORM_MAX_PATH];
	float ChildrenScale;
}

ConVar gModelPathConVar[2];
ConVar gModelScaleConVar[2];
BombData gBombData;

public void OnPluginStart(/*void*/) {
	HookEvent("bomb_planted", OnEventBombPlanted);

	gModelPathConVar[BOMB] = CreateConVar("bomb_path", "", "Model for C4\nInGame: models/weapons/w_c4_planted.mdl");
	gModelPathConVar[CHILDREN] = CreateConVar("bombchr_path", "", "Model for Ent above C4");
	gModelScaleConVar[BOMB] = CreateConVar("bomb_scale", "", "Scale for C4");
	gModelScaleConVar[CHILDREN] = CreateConVar("bombchr_scale", "", "Scale for Ent above C4");
	AutoExecConfig(true, "qcustombomb");
}

public void OnConfigsExecuted(/*void*/) {
	gModelPathConVar[BOMB].GetString(gBombData.BombPath, PLATFORM_MAX_PATH);
	gModelPathConVar[CHILDREN].GetString(gBombData.ChildrenPath, PLATFORM_MAX_PATH);
	gBombData.BombScale = gModelScaleConVar[BOMB].FloatValue;
	gBombData.ChildrenScale = gModelScaleConVar[CHILDREN].FloatValue;

	if ( !StrEqual(gBombData.BombPath, "") ) {
		PrecacheModel(gBombData.BombPath, true);
	}
	if ( !StrEqual(gBombData.ChildrenPath, "") ) {
		PrecacheModel(gBombData.ChildrenPath, true);
	}
}


/*public void OnEntityCreated(int iEntity, const char[] sClassName) {
	if ( StrEqual(sClassName, "planted_c4") ) {
		//RequestFrame -> EditBombSettings(iEntity);
	}
}*/

public Action OnEventBombPlanted(Event eEvent, const char[] sName, bool bDontBroadcast) {
	int iEnt = -1;
	while( (iEnt = FindEntityByClassname(iEnt, "planted_c4")) != -1 ) {
		EditBombSettings(iEnt);
	}
}

void EditBombSettings(int iBomb) {
	if ( !StrEqual(gBombData.BombPath, "") ) {
		SetEntityModel(iBomb, gBombData.BombPath);
	}
	if ( gBombData.BombScale ) {
		SetEntPropFloat(iBomb, Prop_Send, "m_flModelScale", gBombData.BombScale);
	}

	if ( !StrEqual(gBombData.ChildrenPath, "") ) {
		float fPos[3];
		GetEntPropVector(iBomb, Prop_Data, "m_vecAbsOrigin", fPos);

		int iAboveEnt = CreateEntityByName("prop_dynamic");
		if ( iAboveEnt != -1 ) {

			DispatchKeyValueVector(iAboveEnt, "origin", fPos);
			DispatchKeyValue(iAboveEnt, "model", gBombData.ChildrenPath);
			DispatchSpawn(iAboveEnt);

			if ( gBombData.BombScale ) {
				DispatchKeyValueFloat(iAboveEnt, "modelscale", gBombData.ChildrenScale); 
				SetEntPropFloat(iAboveEnt, Prop_Send, "m_flModelScale", gBombData.ChildrenScale);
			}

			SetVariantString("!activator");
			AcceptEntityInput(iAboveEnt, "SetParent", iBomb, iAboveEnt);
			SetEntPropEnt(iBomb, Prop_Data, "m_hOwnerEntity", iAboveEnt);
		}
	}
}