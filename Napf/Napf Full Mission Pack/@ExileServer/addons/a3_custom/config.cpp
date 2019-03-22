class CfgPatches {
	class A3_custom {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
	};
};

class CfgFunctions {
	class A3C {
		class A3CCustom {
			file = "a3_custom\init";
			class init {
				postInit = 1;
			};
		};
	};
};