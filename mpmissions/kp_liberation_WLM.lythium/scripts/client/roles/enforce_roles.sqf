#include "../../WolfLabs/macros.hpp"

private ["_idMatch", "_query", "_result", "_target", "_playerType", "_uid", "_isAdm","_isMed", "_isEng", "isInt","_isPie","_isSnipe"];

waitUntil { alive player } ;
sleep 1;

_target = player;
_playerType = typeOf _target;
_uid = getPlayerUID _target;

_ignoreTypes[] = {"B_Soldier_F", "B_soldier_exp_F", "B_Soldier_TL_F", "B_Soldier_SL_F", "B_officer_F"};

if (!isNull _target ) then {
	if (([] call BIS_fnc_admin) != 1) then {
		_query = format ["SELECT * FROM players WHERE uid='%1'",_uid];
			_result = [_query,2] call DB_fnc_asyncCall;

			_idmatch = false;

		/* FINNA MAKE NOT FOUND*/
		
		if ((_result select 3) isEqualTo 1) then  { //Admin - No Checks for you.
			_idmatch = true;
		} else {
			
			if ( _playerType == "B_medic_F" ) then {
				if ( (_result select 4) isEqualTo 1 ) then {
					_idmatch = true;
				};
			};

			if ( _playerType == "B_engineer_F" ) then {
				if ( (_result select 5) isEqualTo 1 ) then {
					_idmatch = true;
				};
			};
			
			if ( _playerType == "B_recon_F" ) then {
				if ( (_result select 8) isEqualTo 1 ) then {
					_idmatch = true;
				};
			};
			
			if ( _playerType == "B_Helipilot_F" ) then {
				if ( (_result select 7) isEqualTo 1 ) then {
					_idmatch = true;
				};
			};
			
			if ( _playerType == "B_soldier_UAV_F" ) then {
				if ( (_result select 6) isEqualTo 1 ) then {
					_idmatch = true;
				};
			};

			if ( _playerType == "B_Officer_F" ) then {
				if ( (_result select 9) isEqualTo 1 ) then {
					_idmatch = true;
				};
			};
			
			if( _playerType in _ignoreTypes) then { //No Checks Needed.
					_idmatch = true;
			};
		};
		if ( !(_idmatch ) ) then { //All Checks Failed, Lobby Kick.

			sleep 1;
			if ( alive _target ) then {
				endMission "End2";
			};
		};
	};
};