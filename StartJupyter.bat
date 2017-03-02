@ECHO OFF

SET "MyVEDir=C:\Anaconda3\envs"

IF "%1"=="" (
     ECHO Enter Virtual Environment name to start Jupyter in 
     SET /P MyVE= Or 'Enter' to start in the root Environment: 
) ELSE ( SET MyVE="%1" )

IF "%MyVE%"== """" ( 
    GOTO ArgMissing ) 

IF "%MyVE%"=="root" (
    ECHO Starting Jupyter in the "root" Environment
    GOTO StartVE)

IF exist "%MyVEDir%\%MyVE%" (
    ECHO Starting Jupyter in %MyVE% Environment
    GOTO StartVE ) ELSE (
    GOTO MissingVE   
   )
   
REM If the execution got to here, it's a bug
ECHO Something went wrong with the script. 
ECHO Try again or better: fix it! :-(

:ArgMissing
ECHO Virtual Environment to start Jupyter not given.
ECHO Starting in the Root Environment.
GOTO StartVE

:MissingVE
ECHO Missing the Virtual Environment %MyVE%
ECHO Starting Jupyter in the Root Environment.
SET MyVE=""
GOTO StartVE

:StartVE
IF NOT MyVE=="" ( CALL activate %MyVE% )
start jupyter notebook
GOTO EndScript

:EndScript
REM Reset all variables, in case we call this
REM script again from the same shell
SET MyVE=""
SET MyVEDir=""
GOTO :EOF
