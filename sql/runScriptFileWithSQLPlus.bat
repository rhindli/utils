SET scriptfile=<path_to_script_file>
SET username=<username>
SET password=<password>
SET db=<dbname>
(
ECHO @%scriptfile%
::other inputs for prompts running the script file here using ECHO for each prompt
::ECHO sotest
::ECHO ""
ECHO exit
) | sqlplus %username%/%password%@%db% > out.txt

pause.