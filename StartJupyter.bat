@ECHO OFF

SET "VirtualEnvDir=C:\Anaconda3\envs"

IF "%1" == "" (SET /P VirtualEnv= Enter Virtual Environment name to start Jupyter in: 
IF VirtualEnv == "" (GOTO :ArgMissing)) ELSE ( SET VirtualEnv = %1 )

IF exist %VirtualEnvDir%\%VirtualEnv% (GOTO :StartVE) ELSE (GOTO :MissingVE)

:StartVE
Echo Starting Jupyter in Virtual Environment %VirtualEnv% 
CALL activate %VirtualEnv%
start jupyter notebook
GOTO :EOF

:MissingVE
ECHO Missing the Virtual Environment %VirtualEnv%
ECHO Bailing out!
SET /P Tmp= Hit Enter to exit
GOTO :EOF

:ArgMissing
ECHO Virtual Environment %VirtualEnv not found; bailing out
GOTO :EOF


