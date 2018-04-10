
//Scripting Macros
#define CONST(var1,var2) var1 = compileFinal (if (var2 isEqualType "") then {var2} else {str(var2)})
#define CONSTVAR(var) var = compileFinal (if (var isEqualType "") then {var} else {str(var)})
#define FETCH_CONST(var) (call var)
#define CALL_EXTDB "extDB3" callExtension
#define EXTDB_SETTING(TYPE,SETTING) TYPE(missionConfigFile >> "CfgServer" >> SETTING)
#define EXTDB_FAILED(MESSAGE) \
    lib_server_extDB_notLoaded = [true,##MESSAGE]; \
    publicVariable "lib_server_extDB_notLoaded"; \
    diag_log MESSAGE;