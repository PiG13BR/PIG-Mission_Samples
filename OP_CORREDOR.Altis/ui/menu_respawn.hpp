/*
Author: PiG13BR

missionConfigFile >> "PiG_RscRespawnMenu"
*/

class PiG_RscRespawnMenu
{
	idd = 5959;
	movingEnable = false;
    controlsBackground[] = {};
	class controls
	{
		class baseFrame: RscFrame
		{
			idc = -1;
			style = ST_BACKGROUND;

			x = 0.381917 * safezoneW + safezoneX;
			y = 0.219938 * safezoneH + safezoneY;
			w = 0.249286 * safezoneW;
			h = 0.210047 * safezoneH;
			colorBackground[] = COLOR_DARK_GRAY;
		};
		class buttonRespawn: RscButton
		{
			idc = 591600;
			action = "";
			colorDisabled[] = COLOR_LIGHTGRAY_ALPHA;
			colorBackgroundDisabled[] = COLOR_LIGHTGRAY_ALPHA;
			colorBackgroundActive[] = COLOR_BROWN;
			colorFocused[] = COLOR_LIGHTGRAY_ALPHA;

			text = $STR_RESPAWN_MENU_DEPLOY;
			x = 0.460639 * safezoneW + safezoneX;
			y = 0.373972 * safezoneH + safezoneY;
			w = 0.0918423 * safezoneW;
			h = 0.0420094 * safezoneH;
			colorBackground[] = COLOR_LIGHTGRAY_ALPHA;
		};
		class textMenu: RscText
		{
			idc = -1;

			text = $STR_RESPAWN_MENU_TITLE;
			x = 0.447519 * safezoneW + safezoneX;
			y = 0.233941 * safezoneH + safezoneY;
			w = 0.118083 * safezoneW;
			h = 0.0280062 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class textSelect: RscText
		{
			idc = -1;

			text = $STR_RESPAWN_MENU_SELECT;
			x = 0.395037 * safezoneW + safezoneX;
			y = 0.303956 * safezoneH + safezoneY;
			w = 0.216486 * safezoneW;
			h = 0.0280062 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class listBoxRespawn: RscListBox
		{
			idc = 592100;

			x = 0.48688 * safezoneW + safezoneX;
			y = 0.27595 * safezoneH + safezoneY;
			w = 0.124643 * safezoneW;
			h = 0.0840187 * safezoneH;

			class ListScrollBar
			{
				color[] = {1,1,1,1};
				autoScrollEnabled = 1;
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				shadow = 0;
				scrollSpeed = 0.06;
				width = 0;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
			}
		}
	}
}
