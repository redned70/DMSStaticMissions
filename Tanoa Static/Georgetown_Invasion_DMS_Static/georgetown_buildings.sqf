// [CiC]red_ned   cic-gaming.co.uk
// NOT LOADED WITH SERVER!
private ["_objs"];
_objs = [
	["Land_HBarrier_01_line_5_green_F",[5534.24,9917.15,0],346.364,[[-0.235752,0.971813,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5527.07,9915.4,0],346.364,[[-0.235752,0.971813,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5519.7,9913.69,0],346.364,[[-0.235752,0.971813,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5554.61,9906.41,0],68.6364,[[0.931288,0.364285,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5557.05,9900,0],68.6364,[[0.931288,0.364285,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5559.55,9893.38,0],68.6364,[[0.931288,0.364285,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5855.99,10834,0],349.091,[[-0.189249,0.981929,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5848.85,10832.8,0],349.091,[[-0.189249,0.981929,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5871.29,11018.3,0],5.90911,[[0.102951,0.994686,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5856.92,11043.9,0],292.727,[[-0.922356,0.386341,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5992.38,10565.1,0],305,[[-0.819152,0.573577,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5996.99,10571.6,0],305,[[-0.819152,0.573577,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5738.94,9993.64,0],108.182,[[0.95007,-0.312037,0],[0,-0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5736.82,9986.05,0],108.182,[[0.95007,-0.312037,0],[0,-0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5773.12,10185.9,0],8.18182,[[0.142315,0.989821,0],[0,0,1]],false],
	["Land_HBarrier_01_line_5_green_F",[5764.78,10187.1,0],8.18182,[[0.142315,0.989821,0],[0,0,1]],false]
];

{
	private ["_obj"];
	_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	if (_x select 4) then {
		_obj setDir (_x select 2);
		_obj setPos (_x select 1);
	} else {
		_obj setPosATL (_x select 1);
		_obj setVectorDirAndUp (_x select 3);
	};
} foreach _objs;