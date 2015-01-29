set Stamp=%DATE:~-4%%DATE:~-10,2%%DATE:~-7,2%_%TIME:~0,8%
set Stamp=%Stamp::=%
set Stamp=%Stamp: =0%
set Filename=2015MeetingsQ1_%Stamp%.txt

sqlcmd -S DBServerPAth -d DBNAme -U username -P password -i H:\SQLServerDBQueries\2015EventsQ1.sql  -s "|" -o x:\%Filename%
