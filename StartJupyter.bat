@ECHO OFF

ECHO Starting ...

REM If you use this script, remember to change the path to your
REM Anaconda path below appropriately. Normally it should be
REM C:\Program Files\Anaconda3\envs.  It is also found at
REM C:\Users\shankar\AppData\Local\conda\conda\envs\ - not sure how
REM at two locations!
SET "MyVEDir1=C:\ProgramData\Anaconda3\envs"
SET "MyVEDir2=C:\Users\shankar\AppData\Local\conda\conda\envs\"
IF "%1"=="" (
     GOTO PromptBegin
) ELSE ( SET MyVE="%1" )

IF "%MyVE%"== """" (
    GOTO ArgMissing )

IF "%MyVE%"=="root" (
    GOTO StartVE )

:CheckArgAndStart
IF exist "%MyVEDir1%\%MyVE%" (
    GOTO StartVE ) ELSE (
    IF exist "%MyVEDir2%\%MyVE%" (
        GOTO StartVE
    ) ELSE (
    GOTO MissingVE
   ))

REM If the execution got to here, it's a bug
ECHO Something went wrong with the script.
ECHO Try again or better: fix the script and try again! :-(

:PromptBegin
ECHO Enter Virtual Environment name to start Jupyter from.
ECHO Following VEs are available (wait a few seconds ...):
CALL conda info --envs
SET /P MyVE= Or 'Enter' to start in the root Environment:
IF "%MyVE%"=="""" (
   GOTO StartVE ) ELSE (
   GOTO CheckArgAndStart )

:ArgMissing
ECHO Virtual Environment to start Jupyter not given.
ECHO Starting in the Root Environment.
GOTO StartVE

:MissingVE
ECHO Missing the Virtual Environment %MyVE%
GOTO PromptBegin

:StartVE
IF "%MyVE%"=="" (
    ECHO Starting Jupyter in "root" Environment ...
    CALL deactivate
    ) ELSE (
    ECHO Starting Jupyter in %MyVE% Environment ...
    CALL activate %MyVE% )
start jupyter notebook
GOTO EndScript

:EndScript
REM Reset all variables, in case we call this
REM script again from the same shell
SET MyVE=""
SET MyVEDir1=""
SET MyVEDir2=""
EXIT
