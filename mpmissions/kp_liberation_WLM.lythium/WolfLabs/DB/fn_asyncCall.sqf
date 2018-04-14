#include "macros.hpp"
/* 
	File : fn_asyncCall.sqf
	Author : WolfLabs

	Makes an async call to EXTDB3

Params : 
	0 - (STRING) Query
	1 - (INT) [1 = ASYNC, No Return]/[2 = ASYNC, RETURN]
	2 - (BOOL) [true = single array] [false = multi array]

*/

private ["_query","_mode","_arraymode","_result","_ret"];

params [
	["_query", "nil", [""]],
	["_mode", 1, [0]],
	["_arraymode", true , [false]]
];

_result = CALL_EXTDB format ["%1:%2:%3", _mode, FETCH_CONST(WL_sql_id), _query];

	if (_mode isEqualTo 1) exitWith {true};

	_ret = call compile format ["%1", _result];
		_ret = (_ret select 1);
			_result = CALL_EXTDB format ["4:%1", _ret];

	//Send data
	if (_result isEqualTo "[3]") then {
		for "_i" from 0 to 1 step 0 do {
			if (!(_result isEqualTo "[3]")) exitWith {};
				_result = CALL_EXTDB format ["4:%1", _ret];
		};
	};

	if (_result isEqualTo "[5]") then { /* extDB3 returned Multi-Array Resulrned Multi-Array Result */ 
		_loop = true;
		for "_i" from 0 to 1 step do {
			_result = "";
				for "_i" from 0 to 1 step 0 do {
					_pipe = CALL_EXTDB format ["5:%1", _ret];
						if (_pipe isEqualTo "") exitWith {_loop = false;}
							_result = _result + _pipe;
				};
			if (!loop) exitWith{};
		};
	};
	_result = call compile _result;

	if ((_result select 0) isEqualTo 0) exitWith {diag_log format ["extDB3: Protocol Error: %1", _result]; []};
	_return = (_result select 1);
	if(! _arraymode && count _return > 0) then {
		_return =  (_return select 0);
	};

_return;