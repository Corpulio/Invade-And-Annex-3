/*
 * Author: BACONMOP
 * Used for the supports for players and their scores
 *
this addAction ["Sorcher Strike","['Sorcher'] call AW_fnc_supportRequest;"];
this addAction ["MLRS Strike","['MLRS'] call AW_fnc_supportRequest;"];
this addAction ["CAS Strike: Gun Run","['Gun'] call AW_fnc_supportRequest;"];
this addAction ["CAS Strike: Rocket Strike","['Rocket'] call AW_fnc_supportRequest;"];
this addAction ["CAS Strike: Guns and Rockets","['GunRocket'] call AW_fnc_supportRequest;"];
player addScore 75;
 * 
 */
params ["_type"];

switch (_type) do{
	
	case "Sorcher":{
		_allScore = score player;
		if (_allScore >= 5) then {
			player addAction ["Sorcher Strike","_pos = screenToWorld [.5,.5];[artySorcher,_pos] remoteExec ['AW_fnc_artyStrike',2];_supportAddaction = _this select 2;player removeAction _supportAddaction;"];
			_unit = player;
			[_unit,-75] remoteExec ["addScore",0];
		} else {
			hint "You need a total score of 75 points for this support action";
		};
	};
	
	case "MLRS":{
		_allScore = score player;
		if (_allScore >= 10) then {
			player addAction ["MLRS Strike","_pos = screenToWorld [.5,.5];[artyMLRS,_pos] remoteExec ['AW_fnc_artyStrike',2];_supportAddaction = _this select 2;player removeAction _supportAddaction;"];
			_unit = player;
			[_unit,-150] remoteExec ["addScore",0];
		} else {
			hint "You need a total score of 150 points for this support action";
		};
	};
	
	case "Gun":{
		_allScore = score player;
		if (_allScore >= 15) then {
			player addAction ["CAS Strike: Gun Run","_pos = screenToWorld [.5,.5];[_pos,random 360,'B_Plane_CAS_01_F',0] remoteExec ['AW_fnc_createCas',2];_supportAddaction = _this select 2;player removeAction _supportAddaction;"];
			_unit = player;
			[_unit,-90] remoteExec ["addScore",0];
		} else {
			hint "You need a total score of 90 points for this support action";
		};
	};
	
	case "Rocket":{
		_allScore = score player;
		if (_allScore >= 20) then {
			player addAction ["CAS Strike: Rocket Strike","_pos = screenToWorld [.5,.5];[_pos,random 360,'B_Plane_CAS_01_F',1] remoteExec ['AW_fnc_createCas',2];_supportAddaction = _this select 2;player removeAction _supportAddaction;"];
			_unit = player;
			[_unit,-110] remoteExec ["addScore",0];
		} else {
			hint "You need a total score of 110 points for this support action";
		};
	};
	
	case "GunRocket":{
		_allScore = score player;
		if (_allScore >= 25) then {
			player addAction ["CAS Strike: Guns and Rockets","_pos = screenToWorld [.5,.5];[_pos,random 360,'B_Plane_CAS_01_F',2] remoteExec ['AW_fnc_createCas',2];_supportAddaction = _this select 2;player removeAction _supportAddaction;"];
			_unit = player;
			[_unit,-130] remoteExec ["addScore",0];
		} else {
			hint "You need a total score of 130 points for this support action";
		};
	};
};
