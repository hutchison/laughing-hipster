laughing-hipster
================

„laughing hipster“ ist ein Shellskript, welches auf einem Mac folgende Programme
zu Verwaltungszwecken installiert:
* [Homebrew](http://brew.sh/)
* [SaltStack](http://www.saltstack.com/)
* [Munki](https://code.google.com/p/munki/)

Es wird dabei nach bestem Wissen und Gewissen überprüft, ob das Skript auf einem
Mac ausgeführt wird und die zu installierenden Programme nicht schon installiert
sind. Zum Anstoßen der Installation einfach `bootstrap.sh` im Terminal
ausführen. Irgendwann muss man bestimmt mal das eigene Passwort eingeben (zum
Installieren der Programme braucht man Administratorrechte) – `sudo` wird sich
dann schon melden.

Der Name wurde von GitHub vorgeschlagen und war bescheuert genug, dass ich mich
dafür entschieden hab.
