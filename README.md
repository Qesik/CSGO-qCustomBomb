# CSGO-qCustomBomb - Customize bomb
Edit/Scale model bomb and add other model above c4

Plugin doesnt support precache models/materials

![Image](https://forum.cs-classic.pl/uploads/monthly_2021_12/obraz.png.94f2d2cf4102d9ccd281a4f3f2ca66ad.png)

## ConVar
```
// Model for C4
// InGame: models/weapons/w_c4_planted.mdl
// -
// Default: ""
bomb_path ""

// Scale for C4
// -
// Default: ""
bomb_scale ""

// Model for Ent above C4
// -
// Default: ""
bombchr_path "models/nico/models/prop/seasons/deco_snowman_sims4_seasonspack.mdl"

// Scale for Ent above C4
// -
// Default: ""
bombchr_scale ""
```


## Example (snowman)
Add in OnMapStart
```
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
```
Files you can find on my forum:
[qCustomBomb](https://forum.cs-classic.pl/topic/75261-csgo-qcustombomb-custom-bomb-zmodyfikuj-bomb%C4%99-na-serwerze/)
