```
#######################################################################################
# Ce programme modifie les droits CHOWN et CHMOD sur un site web hébergé sous Apache2 #
#                   Script de Zer00CooL pour https://lecannabiste.fr                  #
#                            Développé sous Debian - Ubuntu                           #
#######################################################################################
```
```
# This script fix-apache-permissions.sh can fix Apache permissions CHOWN and CHMOD for Files and Folder from a website Joomla Mediawiki Wordpress and other CMS using HTML and PHP files.
```

```
############################################################
# Script testé avec les CMS suivants hébergés sous Apache2 #
############################################################
```
```
# Joomla
# Mediawiki
# WordPress
```

```
##########################################
# Ce script permet d'optimiser les CHMOD #
##########################################
```
```
### Tests communs pour tous les CMS :
# Tous les CHMOD d'un site avec les valeurs par défaut recommandées.
# Le CHMOD des fichiers index.php index.htm index.html
# Le CHMOD des fichiers .htaccess*
```
```
### Certains CHMOD spécifiques à un CMS :
# Le CHMOD du fichier configuration.php
# Le CHMOD du fichier LocalSettings.php
# Le CHMOD du fichier wp-config.php
```

```
#####################################
# Tester le script de développement #
#####################################
```
```
# Copier le fichier dev-fix-apache-permissions.sh sur votre machine locale.
# https://github.com/ZerooCool/dev-fix-apache-permissions.sh
```
```
# Copier le répertoire "site" qui va servir de site de test.
# https://github.com/ZerooCool/fix-apache-permissions.sh/tree/master/site
```
# Lancer le script puis suivre les étapes proposées :
sudo sh dev-fix-apache-permissions.sh
```

```
##################################################################
# Passer du script de développement vers le script de production #
##################################################################
```
```
# Le script de production est le même que le script en développement.
# Les commentaires sont supprimés ainsi que les lignes vides pour alléger le script.
sed '/^#/d;/    # /d;/    ##/d;/^$/d' dev-fix-apache-permissions.sh > prod-fix-apache-permissions.sh
```
```
# L'entête sera rajouté :
sed -i.old -e "1i\\#\!\/bin\/sh" prod-fix-apache-permissions.sh
sed -i.old -e "2i\\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#" prod-fix-apache-permissions.sh
sed -i.old -e "3i\\# Ce programme modifie les droits CHOWN et CHMOD sur un site web hébergé sous Apache2 \#" prod-fix-apache-permissions.sh
sed -i.old -e "4i\\#                  Script de Zer00CooL pour https://lecannabiste.fr                   \#" prod-fix-apache-permissions.sh
sed -i.old -e "5i\\#                           Développé sous Debian - Ubuntu                            \#" prod-fix-apache-permissions.sh
sed -i.old -e "6i\\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#" prod-fix-apache-permissions.sh
sed -i.old -e "7i\ " prod-fix-apache-permissions.sh
```
```
# Supprimer le fichier de backup prod-fix-apache-permissions.sh.old
```

```
##################################
# Tester le script en production #
##################################
```
```
# Copier le fichier prod-fix-apache-permissions.sh sur votre serveur.
# https://github.com/ZerooCool/prod-apache-permissions.sh
```
```
# Lancer le script puis suivre les étapes proposées :
sudo sh prod-fix-apache-permissions.sh
```
