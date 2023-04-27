
#define SM_REWARD_BASE 10000
#define SM_REWARD_STEP 5000
#define SM_REWWARD_LEVEL(level) (SM_REWARD_BASE + SM_REWARD_STEP * level)

class SideMissions
{

class MissionBase
{
 deleteTargets = true;
 removeActions = false;
 
 targetsMax = 0;

 createGuards = true;
 
 destinationFn = "isBaseNear";
 
 reward = SM_REWARD_BASE;
 
 taskIcon = "default";
};

class FreeCaptives : MissionBase
{
 desc = "Rescue the captives";
 
 composition = "hostageCamp";
 
 startInfo = "Secure the captives";
 
 targetsMax = "1 + (round(random 2))";
 targetTypes[] = {"C_man_1","C_man_polo_2_F"};
 
 start = "[] call smSetupCaptives";
 loop = "call smTakeControlTargets";
 
 targetsReached = "call smRescueCaptives";  // Join plr
 targetsReachedMsg = "Escort the captives back to base";
 
 targetsDiedMsg = "The captives died";
 
 taskIcon = "meet";
};

class RescuePilot : MissionBase
{
 desc = "Rescue the downed pilot";
 
 composition = "downedPilot";
 
 startInfo = "Rescue the pilot";
 
 targetsMax = "1";
 targetTypes[] = {"B_Fighter_Pilot_F"};

 createGuards = false;
 
 start = "[] call smSetupRescuableMen";
 loop = "call smTakeControlTargets";
 
 targetsReached = "call smRescueMen";
 targetsReachedMsg = "Bring the pilot back to the base";
 
 targetsDiedMsg = "The pilot died";
 
 taskIcon = "meet";
};

class CaptureOfficer : FreeCaptives
{
 desc = "Capture enemy officer";
 
 composition = "hqCamp1";
 
 startInfo = "Arrest enemy officer";
 
 start = "[] call smSetupOfficers";
 
 targetsMax = 1;
 targetTypes[] = {"I_officer_F"};
 
 targetsReached = "call smArrestOfficer";
 targetsReachedMsg = "Take the officer back to base";
 
 targetsDiedMsg = "The officer died";
 
 taskIcon = "meet";
};

class DestroyObjects : MissionBase
{
 //desc = "";
 
 //targetTypes[] = {"Land_Radar_Small_F"};
 //targetsMax = 1;
 deleteTargets = false;
 
 loop = "call smDestroyTargets";
 
 taskIcon = "destroy";
};

class DestroyRadar : DestroyObjects
{
 desc = "Destroy radar";
 
 composition = "radarplace";
 
 targetTypes[] = {"Land_Radar_Small_F"};
 targetsMax = 1;
 
};

class EliminateEnemy : DestroyObjects
{
 desc = "Eliminate officer";
 
 composition = "hqCamp2";
 
 targetTypes[] = {"I_officer_F"};
 targetsMax = 1;
 targetIsDefender = true;
 
 taskIcon = "kill";
};

class AccessComputer : MissionBase
{
 desc = "Download data from enemy PC";
 
 composition = "campLaptop";
 targetTypes[] = {"Land_Laptop_device_F"};
 targetsMax = 1;
 
 start = "[] call smSetupAccessComputer";
 loop = "call smAccessComputer";
 
 deleteTargets = false;
 removeActions = true;
 
 taskIcon = "download";
};

class ScoutArea : MissionBase
{
 desc = "Find enemy base";
 taskIcon = "scout";
 
 smOnScoutComplete = "call smEndScoutMission";
};

};

// Asassination
// Interrogation
// Recon area
// Spot target
// Defuse bomb
