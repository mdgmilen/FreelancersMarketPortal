#!/bin/bash

# For how-to-use /USAGE the current script information, please find /see the showUsefulCommands() function below

dirScriptStartedFrom=${PWD}
pathGitHome=/home/mileng/UserMb5400im1/projects/git
nameCurrentScript=orchestration_local
pathCurrentScript=$pathGitHome/FreelancersMarketPortal/orchestrationLocal
cmdCheckFe="ps -aux | grep mileng | grep \"ng serve\""
cmdCheckFeActual=$cmdCheckFe" | grep -v \"grep ng serve\""
cmdCheckFreempSproduct="ps -aux | grep mileng | grep \"java -jar\""
cmdCheckFreempSproductActual=$cmdCheckFreempSproduct" | grep -v \"grep java -jar\""

showDebugInfoParam1="there are no params"
paramsCount=$#
if [ $paramsCount -gt 0 ]
then
  showDebugInfoParam1=$1
fi
showDebugInfo=false
if [ $showDebugInfoParam1 = "debug" ]
then
  showDebugInfo=true
fi

execThreeChecks ()
{
    echo "Executing...1 '$cmdCheckFe'"
    eval $cmdCheckFeActual
    echo "Executing...2 '$cmdCheckFreempSproduct'"
    eval $cmdCheckFreempSproductActual
    echo "Executing...3 'ps -ef | grep defunct'"
    ps -ef | grep defunct | grep -v "grep defunct"
}
execAfterStartCommands ()
{
    echo "AFTER-START status commands"
    execThreeChecks
    echo "..."
    echo "..."
}
execBeforeFinishCommands ()
{
    echo "..."
    echo "..."
    echo "BEFORE-FINISH status commands'"
    execThreeChecks
}
showUsefulCommands ()
{
    echo "Entering...'showUsefulCommands()'"
    echo "useful command 0: USAGE: 'With or without 'debug' parameter. With it the script will show more information"
    echo "useful command 0: USAGE: '. /home/mileng/UserMb5400im1/projects/git/orchestrationLocal/orchestration_local.sh debug'"
    echo "useful command 0: USAGE: '. /home/mileng/UserMb5400im1/projects/git/orchestrationLocal/orchestration_local.sh'"
    echo "useful command 1: 'kill -SIGINT xxx'"
    echo "useful command 2: 'ps aux | grep mileng | grep -v \"/usr/bin\" | grep -v \"/usr/lib\" | grep -v docker | grep -v \"/bin/zsh\"'"
    echo "useful command 3: 'ps -ef | grep 63722'"
    echo "useful command 4: 'kwrite /run/media/mileng/flashm1/UserMf/1_tasks/tasks.log /home/mileng/UserMb5400im1/projects/git/FreelancersMarketPortal/orchestrationLocal/orchestration_local.sh 2>/dev/null &'"
    echo "Exiting...'showUsefulCommands()'"
    echo "..."
    echo "..."
}
startFrontEnd ()
{
    local pathFe=$pathGitHome/FreempFrontEnd
    echo "..."
    echo "..."
    echo "START FRONT-END"
    if [ $showDebugInfo = "true" ]
    then
      echo "Executing...'cd $pathFe'"
    fi
    cd $pathFe
    local num_of_lines=$(ps -aux | grep mileng | grep "ng serve" | grep -v "grep ng serve" | wc -l)
    #local cmdCheckFeActualWc="ps -aux | grep mileng | grep \"ng serve\" | grep -v \"grep ng serve\" | wc -l"
    echo "Checking if the Front End is started... There is/are '$num_of_lines' open instance(s)..."
    if [ $num_of_lines -lt 1 ]
    then
        echo "Executing...'npm start 1>$pathCurrentScript/1_orchestration_local_FE.log 2>$pathCurrentScript/1_orchestration_local_FE.err &'"
        npm start 1>$pathCurrentScript/1_orchestration_local_FE.log 2>$pathCurrentScript/1_orchestration_local_FE.err &
        echo "Wait 10 seconds..."
        sleep 10s
    else
        echo "INFO There is/are '$num_of_lines' open instance(s)... no need to 'npm start...' again!"
        if [ $showDebugInfo = "true" ]
        then
          sleep 3s
        fi
    fi
    if [ $showDebugInfo = "true" ]
    then
      echo "Exiting...'startFrontEnd()'"
    fi
    echo "..."
    echo "..."
}
startFreempSproduct ()
{
    local pathFreempSproduct=$pathGitHome/FreempSproduct
    echo "..."
    echo "..."
    echo "START FreempSproduct"
    if [ $showDebugInfo = "true" ]
    then
      echo "Executing...'cd $pathFreempSproduct'"
    fi
    cd $pathFreempSproduct
    local num_of_lines=$(ps -aux | grep mileng | grep "java -jar" | grep -v "grep java -jar" | wc -l)
    #local cmdCheckFeActualWc="ps -aux | grep mileng | grep \"ng serve\" | grep -v \"grep ng serve\" | wc -l"
    echo "Checking if the FreempSproduct is started... There is/are '$num_of_lines' open instance(s)..."
    if [ $num_of_lines -lt 1 ]
    then
        echo "Executing...'java -jar build/libs/FreempSproduct-0.0.1-SNAPSHOT.jar com.improve1.freemp_sproduct.FreempSproductApplication 1>$pathCurrentScript/2_orchestration_local_FreempSproduct.log 2>$pathCurrentScript/1_orchestration_local_FreempSproduct.err &'"
        #npm start 1>$pathCurrentScript/1_orchestration_local_FE.log 2>$pathCurrentScript/1_orchestration_local_FE.err &
        java -jar build/libs/FreempSproduct-0.0.1-SNAPSHOT.jar com.improve1.freemp_sproduct.FreempSproductApplication 1>$pathCurrentScript/2_orchestration_local_FreempSproduct.log 2>$pathCurrentScript/1_orchestration_local_FreempSproduct.err &
        echo "Wait 10 seconds..."
        sleep 10s
    else
        echo "INFO There is/are '$num_of_lines' open instance(s)... no need to 'java -jar build/libs/FreempSproduct...' again!"
        if [ $showDebugInfo = "true" ]
        then
          sleep 3s
        fi
    fi
    if [ $showDebugInfo = "true" ]
    then
      echo "Exiting...'startFreempSproduct()'"
    fi
    echo "..."
    echo "..."
}

#MAIN method :)
echo "Starting orchestration_local.sh ..."
if [ $showDebugInfo = "true" ]
then
  execAfterStartCommands
fi
startFrontEnd
startFreempSproduct
if [ $showDebugInfo = "true" ]
then
  execBeforeFinishCommands
  showUsefulCommands
fi
cd $dirScriptStartedFrom
echo "Finishing orchestration_local.sh ..."
