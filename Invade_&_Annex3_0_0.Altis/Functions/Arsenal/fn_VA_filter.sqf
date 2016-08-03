#include "arsenalDefines.hpp"
/*
* Author: alganthe
* Filter the arsenal for a given box and add an unfucked arsenal action
*
* Arguments:
* 0: Array of objects <ARRAY>
* 1: filter <NUMBER 0: arsenal unavailable, 1: Arsenal available but filtered, 2: arsenal available unfiltered>
*
* Return Value:
* Nothing
*
* Example:
* [_this, 1] call derp_fnc_VA_filter;
*/
params ["_arsenalBoxes", "_filter"];

switch (_filter) do {

    case 0: {
        {
            [_x , [true], true] call BIS_fnc_removeVirtualItemCargo;
            [_x, [true], true] call BIS_fnc_removeVirtualWeaponCargo;
        } foreach _arsenalBoxes;
    };

    case 1: {
        {
            ["AmmoboxInit", [_x, true, {true}]] call BIS_fnc_arsenal;
            [_x, [true], true] call BIS_fnc_removeVirtualItemCargo;
            [_x, [true], true] call BIS_fnc_removeVirtualWeaponCargo;
            [_x, [true], true] call BIS_fnc_removeVirtualBackpackCargo;
        } foreach _arsenalBoxes;



        private _availableItems = [] call derp_fnc_findItemList;

        _availableItems = (((((((_availableItems - ArsenalWeaponBlacklist)  - ArsenalBlacklistedItems) - ArsenalBlacklistedUniforms) - ArsenalBlacklistedHelmets) - ArsenalBlacklistedGlasses) - ArsenalBlacklistedBackpacks) - ArsenalBlacklistedVests);

        {
            [_x, _availableItems, true] call BIS_fnc_addVirtualItemCargo;
            [_x, _availableItems, true] call BIS_fnc_addVirtualWeaponCargo;
            [_x, _availableItems, true] call BIS_fnc_addVirtualBackpackCargo;
        } foreach _arsenalBoxes;

        {
            _x removeAction (_x getVariable "bis_fnc_arsenal_action");
            _action = _x addaction [
            localize "STR_A3_Arsenal",

            {
                params ["_box", "_unit"];
                ["Open", [nil, _box, _unit]] call bis_fnc_arsenal;

                [_unit] spawn {
                    params ["_unit"];

                    uiSleep 2;
                    (uinamespace getvariable "bis_fnc_arsenal_display") displayAddEventHandler ["Unload", {
                        [player, 0] call derp_fnc_gearLimitations;
                    }];
                };
            },
            [],
            6,
            true,
            false,
            "",
            "
                _cargo = _target getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
                if ({count _x > 0} count _cargo == 0) then {
                _target removeaction (_target getvariable ['bis_fnc_arsenal_action',-1]);
                _target setvariable ['bis_fnc_arsenal_action',nil];
                };
                _condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
                alive _target && {_target distance _this < 5} && {call _condition}
            "
            ];
            _x setvariable ["bis_fnc_arsenal_action", _action];
        } foreach _arsenalBoxes;
    };

    case 2: {
        {
            ["AmmoboxInit", [_x, true, {true}]] call BIS_fnc_arsenal;
        } foreach _arsenalBoxes;
    };
};