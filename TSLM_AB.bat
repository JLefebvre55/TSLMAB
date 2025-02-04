@echo off
set /a lvl=1
:menu
cls
ECHO           *******************************
ECHO           * True Sword and Lots Magic : *
ECHO           *       Adventure Boy         *
ECHO           *******************************
ECHO           *     By Jayden Lefebvre      *
ECHO           *******************************
ECHO.
echo "Copyright V1.1 @2014 pixElle Gaming Industries"
ECHO.
CHOICE /M "Would you like to play?"
IF ERRORLEVEL 2 goto esc

:start
set /a hp=15+(%lvl%*5)
set /a potion=1
set /a mindmg=%lvl%
set /a maxdmg=9+%lvl%
cls
echo "Prepare yourself..."
echo.
echo "Stats:"
echo ********
echo "HP=20"
echo "Damage=%mindmg% to %maxdmg%
echo "Level=%lvl%
echo.
echo Loading...


:randc
set /a num=%random%
if /i %num% GTR 10 goto randc 
if /i %num% LSS 1 goto randc
cls
if /i %num%==1 goto dragon 
if /i %num%==2 goto skeleton 
if /i %num%==3 goto zombie
if /i %num%==4 goto skeleton 
if /i %num%==5 goto dragon
if /i %num%==6 goto zombie 
if /i %num%==7 goto zombie 
if /i %num%==8 goto zombie 
if /i %num%==9 goto skeleton
if /i %num%==10 goto giant

:dragon 
set creaturename=The dragon
set /a creature=%RANDOM% * (40 - 15 + 1) / 32768 + 15
echo "A dragon (HP "%creature%") is attacking you!" 
goto atkend

:giant
set creaturename=The giant
set /a creature=%RANDOM% * (60 - 25 + 1) / 32768 + 25
echo "A giant (HP "%creature%") is attacking you!" 
goto atkend

:skeleton 
set creaturename=The skeleton
set /a creature=%RANDOM% * (20 - 10 + 1) / 32768 + 10
echo "A skeleton (HP %creature%) is attacking you!"
goto atkend

:zombie 
set creaturename=The zombie
set /a creature=%RANDOM% * (15 - 10 + 1) / 32768 + 10
echo "A zombie (HP %creature%) is attacking you!" 

:atkend
timeout 1 >null
echo "What would you like to do?"
CHOICE /M "S=Sword, M=Magic, P=Healing Potion, R=Run Away" /C:SMPR
if errorlevel 4 goto Run
if errorlevel 3 goto Pot
IF ERRORLEVEL 2 GOTO Mag
IF ERRORLEVEL 1 GOTO Swo

:Run 
ECHO "You ran away..."
GOTO dmgskip

:Pot
if /i %potion% LSS 1 goto nopotion
echo "You used your healing potion!
set /a hp=20
set /a potion=%potion%-1
echo "You now have %hp% HP!
timeout 1 >null
goto enemyatk


:Mag
ECHO "You used magic!"
GOTO Load

:Swo
ECHO "You used sword!"
GOTO Load

:Load
echo Loading...

:dmgstart
set /a dmg=%random%
if /i %dmg% GTR %maxdmg% goto dmgstart
if /i %dmg% LSS %mindmg% goto dmgstart
cls

echo "You did %dmg% damage!"
SET /A creature = %creature% - %dmg%
timeout 1 >null

echo "%creaturename% has %creature% HP left!"
timeout 1 >null
IF /i %creature% gtr 0 goto enemyatk


echo "%creaturename% is dead."
set /a lvl=%lvl%+1
echo You are now level %lvl%!
timeout 1 >null
goto dmgskip

:enemyatk
cls
echo %creaturename% is attacking!
echo Loading...
:randatk
set /a randatk=%random%
if /i %randatk% GTR 10 goto randatk
if /i %randatk% LSS 1 goto randatk
cls
set /a hp=%hp%-%randatk%
echo %creaturename% did %randatk% damage!
timeout 1 >null
echo You have %hp% HP left.
if /i %hp% LSS 1 goto dead
pause
cls
goto atkend

:dead
echo "You have fallen..."
timeout 3 >null

:dmgskip
choice /m "Continue? M=Main Menu" /c:ynm
If errorlevel 3 goto menu
If errorlevel 2 goto highscoreend
goto start

:esc
cls
pause
exit

:nopotion
echo "You have no more potions!"
timeout 3 >null
cls
goto atkend

:highscoreend
echo "Name for highscores:"
set /p name= 
echo "%name%=Level %lvl%" >highscores"%name%".txt
goto esc
