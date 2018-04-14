#include "macros.hpp"

/*
	File : fn_insertPlayer.sqf

	Inserts a new player's data into the Whitelisted Roles sheet from the DB.

	Authors : WolfLabs
	
*/

private ["_uid","_name"];

params [
	["_uid", -1, [0]],
	["_name", "nil", [""]]
];

_query = format ["INSERT into players (name, uid) VALUES ('%1','%2')",_name,_uid];
	_result = [_query,1] call DB_fnc_asyncCall;
	