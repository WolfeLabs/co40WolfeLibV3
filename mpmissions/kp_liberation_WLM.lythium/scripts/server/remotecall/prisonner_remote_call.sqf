params[ 
	["_unit"],
	["_loc"]
];
private _milita_prisonner_intel_yield = 3;
private _csat_prisonner_intel_yield = 6;

switch (_loc) do{

	case 0:{
		if (isServer) then {
			private _yield = _csat_prisonner_intel_yield;
			if ((typeof _unit) in militia_squad) then {
				_yield = _milita_prisonner_intel_yield;
			};
			resources_intel = resources_intel + ( _yield + (round (random _yield)));
			stats_prisonners_captured = stats_prisonners_captured + 1;

			[0] remoteExec ["remote_call_intel"];
		};
	};

	case 1: {
	
			if (isServer) then {
			private _yield = _csat_prisonner_intel_yield;
			if ((typeof _unit) in militia_squad) then {
				_yield = _milita_prisonner_intel_yield;
			};
			resources_intel = resources_intel + ( _yield + (round (random _yield)));
			resources_intel = resources_intel / 2;
			stats_prisonners_captured = stats_prisonners_captured + 1;

			[0] remoteExec ["remote_call_intel"];
			};
		};
		
};
