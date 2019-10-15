# PowerShell scripts to copy files and registry keys to read logs on machine without services, that have been created that logs
There are 2 scripts. 
First - export-log.ps1
That script for exporting data from source machine. You should run it in the syntax like above:
.\export-log.ps1 exchange
Then the script will create folde exchange, and it will put here dumps of all registry trees from HKLM\SYSTEM\CurrentControlSet\services\eventlog where name like exchange. Also the script will copy all files from properties of those trees to the same folder. 
After script finishes its work, you should copy created folder to the computer where logs cannot be readeln and run second script :
.\import-log.ps1 exchange
That script will copy all files to c:\CustomEvents\exchange (for example). Folder C:\CustomEvents - must be created before starting script. After copying files, it will import registry dumps, and change paths to files, to folder where files were copyed. 

More details at my blog (Russian language) - https://www.mytechnote.ru/article/centralizovannyy-sbor-logov-v-windows-s-raznyh-kompyuterov-shtatnymi-sredstvami
