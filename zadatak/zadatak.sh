
## Zadatak ovde
## Napisati skriptu koja ce proveravati da li je server ziv 
## i ako nije, restartovati ga (prvo stop pa start)
## DODATNO:
## Skripta treba da se izvrsava perioedicno, svakih 1 minun kao cronjob
## crontab -e 
## Skipta takodje treba da vodi racuna o logovanju i da u slucaju greske
## posalje email obavestenje na email adresu alerts-linux@rajak.rs

source config.sh
source logger.sh
source healthcheck-lib.sh
