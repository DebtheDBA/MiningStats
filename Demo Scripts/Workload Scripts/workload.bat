echo off;
start sqlcmd.exe -S localhost -E -d StackOverflow_MimicUse -i "C:\GitRepo\MiningStats\Workload_Scripts\103 - StackOverflow_MimicUse Create new posts.sql"
start sqlcmd.exe -S localhost -E -d StackOverflow_MimicUse -i "C:\GitRepo\MiningStats\Workload_Scripts\105 - StackOverflow_MimicUse Create Votes.sql"
start sqlcmd.exe -S localhost -E -d StackOverflow_MimicUse -i "C:\GitRepo\MiningStats\Workload_Scripts\107 - StackOverflow_MimicUse Create Comments.sql"
start sqlcmd.exe -S localhost -E -d StackOverflow_MimicUse -i "C:\GitRepo\MiningStats\Workload_Scripts\109 - StackOverflow_MimicUse Top Post Summary.sql" -o "C:\GitRepo\MiningStats\Workload_Scripts\summaryoutput.txt"

