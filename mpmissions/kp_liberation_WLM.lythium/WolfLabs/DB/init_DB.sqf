#include "macros.hpp"
/*
	File : init_DB.sqf

	I hate this file, it made me use macros.

	Author : WolfLabs

*/
if (isNil {uiNamespace getVariable "WL_sql_id"}) then {
	
    WL_sql_id = round(random(9999));
    CONSTVAR(WL_sql_id);
    uiNamespace setVariable ["WL_sql_id",WL_sql_id];
        try {
        _result = CALL_EXTDB format ["9:ADD_DATABASE:%1",EXTDB_SETTING(getText,"DatabaseName")];
        if (!(_result isEqualTo "[1]")) then {throw "extDB3: Error with Database Connection"};
        _result = CALL_EXTDB format ["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2",FETCH_CONST(WL_sql_id),EXTDB_SETTING(getText,"DatabaseName")];
        if (!(_result isEqualTo "[1]")) then {throw "extDB3: Error with Database Connection"};
    } catch {
        diag_log _exception;
        _extDBNotLoaded = [true, _exception];
    };
    if (_extDBNotLoaded isEqualType []) exitWith {};
    EXTDB "9:LOCK";
    diag_log "extDB3: Connected to Database";
} else {
    WL_sql_id = uiNamespace getVariable "WL_sql_id";
    CONSTVAR(WL_sql_id);
    diag_log "extDB3: Still Connected to Database";
};

if (_extDBNotLoaded isEqualType []) exitWith {
    lib_server_extDB_notLoaded = true;
    publicVariable "lib_server_extDB_notLoaded";
};
lib_server_extDB_notLoaded = false;
publicVariable "lib_server_extDB_notLoaded";