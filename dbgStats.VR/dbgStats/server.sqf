
toggleFPSServer =
{
params ["_on"];

if(!isnil "hServFSP") then
{
terminate hServFSP;
};

if(_on) then
{
hServFSP = [] spawn
{
  while { true } do
  {
   (round diag_fps) remoteExecCall ["serverReportingFPS", call targetClients];
   sleep 5;
  };
};
};

};



