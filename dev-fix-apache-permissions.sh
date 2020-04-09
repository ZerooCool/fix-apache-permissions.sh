#!/bin/sh
#######################################################################################
# Ce programme modifie les droits CHOWN et CHMOD sur un site web hébergé sous Apache2 #
#                  Script de Zer00CooL pour https://lecannabiste.fr                   #
#                           Développé sous Debian - Ubuntu                            #
#######################################################################################

# L'écran existant est vidé.
clear;
echo "##################################################################";
sleep 1;
echo "# Ce programme modifie les droits CHOWN et CHMOD sur un site web #";
sleep 2;
echo "#        Script de Zer00CooL pour https://lecannabiste.fr        #";
sleep 2;
echo "#                 Développé sous Debian - Ubuntu                 #";
sleep 2;
echo "##################################################################";
sleep 4;
echo "";


# A faire :
# Récupérer la variable de l'emplacement du site donné en paramètre
# sudo sh fix-apache-permissions.sh /var/www/dossier_du_site_pour_lequel_verifier_les_permissions/


# L'écran existant est vidé.
clear;
echo "#########################################################";
sleep 1;
echo "# Saisir le chemin complet du dossier contenant le site #";
sleep 2;
echo "#########################################################";
sleep 2;
echo "";
echo "Exemple : /var/www/dossier_du_site_pour_lequel_verifier_les_permissions/";
sleep 2;
echo "";
echo "À votre tour :";
read -r chemin_site;
sleep 2;
echo "";
    # Affichage de la variable chemin_site :
    if test -z "$chemin_site"
    then
        echo "Erreur ! Le programme a été arrêté.";
        echo "Le chemin du site n'a pas été renseigné.";
        echo "Relancer le programme avec un emplacement valide pour le site a configurer.";
        sleep 4;
        exit;
    else
        echo "Le dossier renseigné comme contenant le site est le suivant :";
        echo "$chemin_site";

    fi
sleep 2;
echo "";


# L'écran existant est vidé.
clear;
# Vérifier si le dossier du site existe.
# Cette vérification n'est pas affichée car le sleep est commenté.
# Si le dossier existe, on se positionne à l'intérieur.
# Si le dossier n'existe pas, une erreur arrête le programme.
# On passe à la prochaine étape, pour confirmer la poursuite du programme.
if [ -d "$chemin_site" ];
then

    # On se positionne dans le dossier du site en respectant la norme SC2164.
    # cd "$chemin_site" || "exit;";
    # SC2164 : https://github.com/koalaman/shellcheck/wiki/SC2164
    # L'alternative est d'utiliser un test conditionnel pour afficher un message d'erreur.
    # Normalement je n'ai pas besoin d'afficher de message d'erreur, puis le test de l'existance du dossier du site a déjà été réalisé précédemment.
    if cd "$chemin_site";
    then
        echo "Positionnement dans le dossier du site réussi.";
        sleep 2;
        echo "Les CHMOD des dossiers et fichiers seront modifiés dans le site suivant :";
        pwd;
        sleep 2;
    else
        echo "Erreur ! Le programme a été arrêté.";
        echo "Le positionnement dans le dossier du site $chemin_site a échoué.";
        echo "Relancer le programme avec l'emplacement valide du site a configurer.";
        sleep 4;
        exit;
    fi

# Empêche d'afficher l'erreur de ce type quand le dossier n'existe pas : chmod.sh: 81: cd: can't cd to ko/
else
    echo "Erreur ! Le programme a été arrêté.";
    echo "Le dossier du site $chemin_site n'existe pas.";
    echo "Relancer le programme avec l'emplacement valide du site a configurer.";
    sleep 4;
    exit;
fi


# L'écran existant est vidé.
clear;
# Confirmer la poursuite du programme pour changer les CHMOD :
echo "################################################################";
sleep 1;
echo "# Autoriser le programme à poursuivre pour modifier les droits #";
sleep 2;
echo "################################################################";
sleep 2;
echo "";

echo "Les droits des dossiers et fichiers seront modifiés dans le site suivant :";
pwd;

sleep 2;
echo "";
echo "Chaque proposition de changement de droits pourra être acceptée ou refusée.";
sleep 2;
echo "";
echo "Appuyer sur 'o' ou 'O' pour continuer.";
echo "Toute autre touche arrête le programme sans modifier les droits.";
read -r answer
sleep 1;

    ##############################################
    # Début du programme pour changer les CHMOD. #
    ############################################## 
    if [ "$answer" != "${answer#[Oo]}" ] ;
    then
        clear;
        echo "#################################################################";
        sleep 1;
        echo "# Choix du CMS sur lequel appliquer les modifications de droits #";
        sleep 2;
        echo "#################################################################";
        sleep 2;
        echo "";

        # Choix spécifique pour le CMS à modifier :
        echo "Appuyer sur '1' ou 'j' pour modifier les CHMOD de Joomla.";
        echo "Appuyer sur '2' ou 'm' pour modifier les CHMOD de Mediawiki.";
        echo "Appuyer sur '3' ou 'w' pour modifier les CHMOD de WordPress.";
        echo "Toute autre touche arrête le programme sans modifier les CHMOD.";
        # Exemple pour ajouter une entrée dans le menu.
        # echo "Appuyer sur "z" pour modifier les CHMOD de Autre CMS.";
        sleep 2;
        echo "";
        echo "Votre CMS n'est pas dans la liste ?";
        echo "Ce programme peut tout de même être utilisé !";
        echo "Les droits par défaut sont proposés pour chaque CMS.";
        echo "Lancer un CMS au choix et ignorer les étapes spécifiques au CMS.";
        sleep 2;
        echo "";
        echo "Par exemple, vous utilisez le CMS PHPBB3, mais, vous choissisez WordPress :";
        echo "Ignorer alors la configuration du fichier wp-config.php spécifique à WordPress.";
        sleep 2;
        echo "";
        echo "Sélectionner le CMS a utiliser :";
        read -r cms;

        # L'écran existant est vidé.
        clear;
        case $cms in
            1|j|J)
                echo "Le CMS sélectionné est Joomla";
                sleep 2;
                echo "";
            # Fin du choix spécifique à Joomla ;;
            ;;

            2|m|M)
                echo "Le CMS sélectionné est Mediawiki";
                sleep 2;
                echo "";
            # Fin du choix spécifique à Mediawiki ;;
            ;;

            3|w|W)
                echo "Le CMS sélectionné est Wordpress";
                sleep 2;
                echo "";
            # Fin du choix spécifique à WordPress ;;
            ;;

            ## Début pour ajouter une nouvelle entrée au menu de choix des CMS.
            # z|Z)
            #    echo "Le CMS sélectionné est Autre CMS";
            #    sleep 2;
            #    echo "";
            # # Fin du choix spécifique à "Nom du CMS" ;;
            # ;;
            ## Fin pour ajouter une nouvelle entrée au menu de choix des CMS.

            *)
                sleep 2;
                echo "";
                echo "Vous avez décidé de ne pas procéder au changement des droits CHMOD.";
                echo "Le programme a été arrêté sans avoir effectué de modifications.";
                exit;

            # Fin du choix d'arrêt du programme ;;
            ;;
        esac

######

# Début des différentes configuration de CHOWN et CHMOD pour le CMS identifié.
# Les étapes entre ###### sont effectuées à la suite l'une de l'autre.

# Le choix du CMS a configurer a été effectué précédemment.
# Le test conditionnel détermine si la configuration doit être effectuée.
# "1" | "j" | "J" | "2" | "m" | "M" | "3" | "w" | "W")

######

        # Définir le CHOWN des fichiers du site :
        case $cms in
            "1" | "j" | "J" | "2" | "m" | "M" | "3" | "w" | "W")
                # echo "Cette condition vaut pour tous les CMS.";

                # L'écran existant est vidé.
                clear
                echo "######################################################";
                sleep 1;
                echo "# Appliquer le CHOWN recommandé aux fichiers du site #";
                sleep 2;
                echo "######################################################";
                sleep 2;
                echo "";
                echo "Il est important de donner les fichiers au bon propriétaire et groupe.";
                sleep 2
                echo "";
                echo "Appuyer sur 'o' pour sélectionner le CHOWN a appliquer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then
                
                        echo "";
                        echo "Saisir le propriétaire des fichiers du site sur le serveur.";
                        echo "On utilisera généralement la valeur 'www-data', sans les simples quotes.";
                        echo "À votre tour :";
                        read -r wpowner;

                        echo "";
                        echo "Saisir le groupe utilisateur des fichiers du site sur le serveur.";
                        echo "On utilisera généralement la valeur 'www-data', sans les simples quotes.";
                        echo "À votre tour :";
                        read -r wpgroup;

                        echo "";
                        echo "Saisir le groupe du serveur web Apache2.";
                        echo "On utilisera généralement la valeur 'www-data', sans les simples quotes.";
                        echo "À votre tour :";
                        read -r wsgroup;
                        
                        # Afficher le chemin absolu du site :
                            chemin_du_site() {
                                pwd;
                            }
                        # echo "La position du site sur le serveur : $(chemin_du_site)";

                        WP_OWNER="$wpowner"; # Propriétaire des fichiers WordPress.
                        WP_GROUP="$wpgroup"; # Groupe WordPress.
                        WP_ROOT="$(chemin_du_site)"; # Emplacement du site WordPress.
                        WS_GROUP="$wsgroup"; # Groupe du serveur Apache2.

                        # Remise à zéro des droits de propriété des fichiers :
                        echo "";
                        echo "1- Remise à zéro des droits de propriété des fichiers :";
                        find ${WP_ROOT} -exec chown ${WP_OWNER}:${WP_GROUP} {} \;
                        echo "OK.";
                        echo "Il faudra encore ajouter un test pour vérifier si la requête est réalisée !";
                        echo "Vérifier l'existance du dossier, ou, que le script a été lancé avec sudo !";
                        
                        # Autoriser WordPress a modifier wp-config.php :
                        echo "";
                        echo "2- Autoriser WordPress a modifier wp-config.php :";
                        chgrp ${WS_GROUP} ${WP_ROOT}/wp-config.php \;
                        # J'ai une erreur sur le chgrp lorsque je lance la configuration sur /var/www/lecannabiste.it A VERIFIER !!! !!!
                        echo "Il faudra encore ajouter un test pour vérifier si la requête est réalisée !";
                        echo "Vérifier l'existance du dossier, ou, que le script a été lancé avec sudo !";

                        # Autoriser WordPress a modifier wp-content :
                        echo "";
                        echo "3- Autoriser WordPress a modifier wp-content :";
                        find ${WP_ROOT}/wp-content -exec chgrp ${WS_GROUP} {} \;
                        # J'ai une erreur sur le chgrp lorsque je lance la configuration sur /var/www/lecannabiste.it A VERIFIER !!! !!!
                        echo "Il faudra encore ajouter un test pour vérifier si la requête est réalisée !";
                        echo "Vérifier l'existance du dossier, ou, que le script a été lancé avec sudo !";

                        echo "Les droits propriétaire et groupe ont été appliqués.";
                        sleep 2;
                    else
                        echo "";
                        echo "Les droits CHOWN n'ont pas été modifiés.";
                        sleep 2;
                    fi
                sleep 2;
                echo "";


            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac

######

        # Ajouter un changement de propriétaire pour le dossier .git et le fichier .gitignore
        
        #Je relance la question sur les droits @Tchoupinax , tu me disais, Les fichiers gits appartient à celui qui les a CLONÉ.
#Mais, en l’occurrence, lorsque je clone le projet Git dans /var/www/ il me faut les droits sudo pour y écrire, donc, à qui appartient le dossier .git ?
#A mon utilisateur monuser:monuser ou root:root
#Ha bah non, je me répond, si je ne dis pas de bêtise, je dois faire un chown monuser:monuser et la, je peux lancer les commit, sans avoir besoin de sudo, et, je m'identifie avec mon compte utilisateur créé sur Gitea.

######

        # Appliquer la modification de CHMOD pour le CMS identifié :
        case $cms in
            "1" | "j" | "J" | "2" | "m" | "M" | "3" | "w" | "W")
                # echo "La condition vaut pour tous les CMS.";

                # Appliquer les droits par défaut aux dossiers et aux fichiers :
                clear;
                echo "#######################################################";
                sleep 1;
                echo "# Appliquer les valeurs CHMOD recommandées par défaut #"
                sleep 2;
                echo "#######################################################";
                sleep 2;
                echo "";
                echo "Il est conseillé d'utiliser le CHMOD 755 pour tous les dossiers."
                sleep 2;
                echo "Il est conseillé d'utiliser le CHMOD 644 pour tous les fichiers.";
                sleep 2;
                echo "";
                echo "Appuyer sur 'o' pour continuer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then
                        echo "";
                        echo "Le CHMOD par défaut pour les dossiers et fichiers a été appliqué.";
                        find . -type d -exec chmod 755 {} \;
                        find . -type f -exec chmod 644 {} \;
                        sleep 2;
                    else
                        echo "";
                        echo "Le CHMOD par défaut pour les dossiers et fichiers n'a pas été appliqué.";
                    fi
                sleep 2;
                echo "";

            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac
        
######

        # Appliquer la modification de CHMOD pour le CMS identifié :
        case $cms in
            "3" | "w" | "W")
                # echo "La condition vaut pour WordPress.";

                # Appliquer le CHMOD recommandé au fichier wp-config.php :
                clear
                echo "##########################################################";
                sleep 1;
                echo "# Appliquer le CHMOD recommandé au fichier wp-config.php #"
                sleep 2;
                echo "##########################################################";
                sleep 2;
                echo "";
                echo "Utiliser 640 est cohérent, 440 ou 400 permet une sécurité plus poussée.";
                echo "";
                echo "Appuyer sur 'o' pour sélectionner le CHMOD a appliquer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then

                        # Vérification de l'existance du fichier wp-config.php
                            if [ -f "wp-config.php" ];
                            then
                                echo "";
                                # Obtenir le CHMOD du fichier wp-config.php
                                function_chmod_wpconfig() {
                                    stat -c '%a' wp-config.php;
                                }
                                # echo "Le fichier wp-config.php existe.";
                                # echo "Son CHMOD actuel de $(function_chmod_wpconfig) peut être modifié :";
                                echo "Le CHMOD actuel du fichier wp-config.php est $(function_chmod_wpconfig) et peut être modifié.";
                                echo "";

                                # Appliquer le CHMOD 640 440 400 :
                                echo "Appliquer le CHMOD 640 au fichier wp-config.php avec la touche '1'.";
                                echo "Appliquer le CHMOD 440 au fichier wp-config.php avec la touche '2'.";
                                echo "Appliquer le CHMOD 400 au fichier wp-config.php avec la touche '3'.";
                                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                                    read -r ans;
                                    case $ans in
                                        1)
                                            find . -name 'wp-config.php' -exec chmod 640 {} \;;;
                                        2)
                                            find . -name 'wp-config.php' -exec chmod 440 {} \;;;
                                        3)
                                            find . -name 'wp-config.php' -exec chmod 400 {} \;;;
                                        *)
                                            echo "";
                                            echo "Le CHMOD du fichier wp-config.php n'a pas été modifié.";
                                         ;;
                                    esac

                                        # Récupérer la valeur du CHMOD sélectionné :
                                        case $ans in
                                            "1" | "a")
                                                chmodwpconfig="640";
                                            ;;
                                            "2" | "b")
                                                chmodwpconfig="440";
                                            ;;
                                            "3" | "c")
                                                chmodwpconfig="400";
                                            ;;
                                        esac

                                    echo"";
                                    echo "Le CHMOD $chmodwpconfig a été appliqué sur le fichier wp-config.php.";

                            else
                                echo "";
                                echo "Attention !";
                                echo "Le fichier wp-config.php n'existe pas.";
                                echo "Si vous êtes sur un site WordPress, votre fichier a peut être été déplacé.";
                                echo "Identifier l'emplacement du fichier wp-config.php et modifier le manuellement :";
                                echo "sudo find . -name 'wp-config.php' -exec chmod 400 {} \;";
                            fi

                    else
                        echo "";
                        echo "Le CHMOD du fichier wp-config.php n'a pas été modifié.";
                    fi
                sleep 2;
                echo "";

            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac
        
######

        # Appliquer la modification de CHMOD pour le CMS identifié :
        case $cms in
            "1" | "j" | "J")
                # echo "La condition vaut pour Joomla.";

                # Appliquer le CHMOD recommandé au fichier configuration.php :
                clear
                echo "##############################################################";
                sleep 1;
                echo "# Appliquer le CHMOD recommandé au fichier configuration.php #"
                sleep 2;
                echo "##############################################################";
                sleep 2;
                echo "";
                echo "Utiliser 640 est cohérent, 440 ou 400 permet une sécurité plus poussée.";
                echo "";
                echo "Appuyer sur 'o' pour sélectionner le CHMOD a appliquer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then

                        # Vérification de l'existance du fichier configuration.php
                            if [ -f "configuration.php" ];
                            then
                                echo "";
                                # Obtenir le CHMOD du fichier configuration.php
                                function_chmod_configuration() {
                                    stat -c '%a' configuration.php;
                                }
                                # echo "Le fichier configuration.php existe.";
                                # echo "Son CHMOD actuel de $(function_chmod_configuration) peut être modifié :";
                                echo "Le CHMOD actuel du fichier configuration.php est $(function_chmod_configuration) et peut être modifié.";
                                echo "";

                                # Appliquer le CHMOD 640 440 400 :
                                echo "Appliquer le CHMOD 640 au fichier configuration.php avec la touche 1 ou a.";
                                echo "Appliquer le CHMOD 440 au fichier configuration.php avec la touche 2 ou b.";
                                echo "Appliquer le CHMOD 400 au fichier configuration.php avec la touche 3 ou c.";
                                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                                    read -r ans;
                                    case $ans in
                                        1|a)
                                            find . -name 'configuration.php' -exec chmod 640 {} \;;;
                                        2|b)
                                            find . -name 'configuration.php' -exec chmod 440 {} \;;;
                                        3|c)
                                            find . -name 'configuration.php' -exec chmod 400 {} \;;;
                                        *)
                                            echo "";
                                            echo "Le CHMOD du fichier configuration.php n'a pas été modifié.";
                                         ;;
                                    esac

                                        # Récupérer la valeur du CHMOD sélectionné :
                                        case $ans in
                                            "1" | "a")
                                                chmodconfiguration="640";
                                            ;;
                                            "2" | "b")
                                                chmodconfiguration="440";
                                            ;;
                                            "3" | "c")
                                                chmodconfiguration="400";
                                            ;;
                                        esac

                                    echo"";
                                    echo "Le CHMOD $chmodconfiguration a été appliqué sur le fichier configuration.php.";

                            else
                                echo "";
                                echo "Attention !";
                                echo "Le fichier configuration.php n'existe pas.";
                                echo "Si vous êtes sur un site Joomla, votre fichier a peut être été déplacé.";
                                echo "Identifier l'emplacement du fichier configuration.php et modifier le manuellement :";
                                echo "sudo find . -name 'configuration.php' -exec chmod 400 {} \;";
                            fi

                    else
                        echo "";
                        echo "Le CHMOD du fichier configuration.php n'a pas été modifié.";
                    fi
                sleep 2;
                echo "";

            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac

######

        # Appliquer la modification de CHMOD pour le CMS identifié :
        case $cms in
            "2" | "m" | "M")
                # echo "La condition vaut pour Mediawiki.";

                # Appliquer le CHMOD recommandé au fichier LocalSettings.php :
                clear
                echo "##############################################################";
                sleep 1;
                echo "# Appliquer le CHMOD recommandé au fichier LocalSettings.php #"
                sleep 2;
                echo "##############################################################";
                sleep 2;
                echo "";
                echo "Utiliser 640 est cohérent.";
                echo "Utiliser 440 ou 400 permet une sécurité plus poussée.";
                echo "";
                echo "Appuyer sur 'o' pour sélectionner le CHMOD a appliquer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then

                        # Vérification de l'existance du fichier LocalSettings.php
                            if [ -f "LocalSettings.php" ];
                            then
                                echo "";
                                # Obtenir le CHMOD du fichier LocalSettings.php
                                function_chmod_localsettings() {
                                    stat -c '%a' LocalSettings.php;
                                }
                                # echo "Le fichier LocalSettings.php existe.";
                                # echo "Son CHMOD actuel de $(function_chmod_localsettings) peut être modifié :";
                                echo "Le CHMOD actuel du fichier LocalSettings.php est $(function_chmod_localsettings) et peut être modifié.";
                                echo "";

                                # Appliquer le CHMOD 640 440 400 :
                                echo "Appliquer le CHMOD 640 au fichier LocalSettings.php avec la touche 1 ou a.";
                                echo "Appliquer le CHMOD 440 au fichier LocalSettings.php avec la touche 2 ou b.";
                                echo "Appliquer le CHMOD 400 au fichier LocalSettings.php avec la touche 3 ou c.";
                                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                                    read -r ans;
                                    case $ans in
                                        1|a)
                                            find . -name 'LocalSettings.php' -exec chmod 640 {} \;;;
                                        2|b)
                                            find . -name 'LocalSettings.php' -exec chmod 440 {} \;;;
                                        3|c)
                                            find . -name 'LocalSettings.php' -exec chmod 400 {} \;;;
                                        *)
                                            echo "";
                                            echo "Le CHMOD du fichier LocalSettings.php n'a pas été modifié.";
                                         ;;
                                    esac

                                        # Récupérer la valeur du CHMOD sélectionné :
                                        case $ans in
                                            "1" | "a")
                                                chmodlocalsettings="640";
                                            ;;
                                            "2" | "b")
                                                chmodlocalsettings="440";
                                            ;;
                                            "3" | "c")
                                                chmodlocalsettings="400";
                                            ;;
                                        esac

                                    echo "";
                                    echo "Le CHMOD $chmodlocalsettings a été appliqué sur le fichier LocalSettings.php.";

                            else
                                echo "";
                                echo "Attention !";
                                echo "Le fichier LocalSettings.php n'existe pas.";
                                echo "Si vous êtes sur un site Mediawiki, votre fichier a peut être été déplacé.";
                                echo "Identifier l'emplacement du fichier LocalSettings.php et modifier le manuellement :";
                                echo "sudo find . -name 'LocalSettings.php' -exec chmod 400 {} \;";
                            fi

                    else
                        echo "";
                        echo "Le CHMOD du fichier LocalSettings.php n'a pas été modifié.";
                    fi
                sleep 2;
                echo "";

            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac
        
######
        
        # Appliquer la modification de CHMOD pour le CMS identifié :
        case $cms in
            "1" | "j" | "J" | "2" | "m" | "M" | "3" | "w" | "W")
                # echo "La condition vaut pour tous les CMS.";

                # Appliquer le CHMOD recommandé aux fichiers index.php, index.htm, index.html :
                clear
                echo "####################################################";
                sleep 1;
                echo "# Appliquer le CHMOD recommandé aux fichiers index #"
                sleep 2;
                echo "####################################################";
                sleep 2;
                echo "";
                echo "Les fichiers index qui seront modifiés : index.php index.htm index.html.";
                echo "Utiliser 644 est cohérent.";
                echo "Utiliser 444 permet une sécurité plus poussée.";
                echo "";
                echo "Appuyer sur 'o' pour sélectionner le CHMOD a appliquer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then

                        # Appliquer le CHMOD 640 440 400 :
                        echo "";
                        echo "Appliquer le CHMOD 644 aux index .php .htm .html avec la touche 1 ou a.";
                        echo "Appliquer le CHMOD 444 aux index .php .htm .html avec la touche 2 ou b.";
                        echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                            read -r ans;
                                case $ans in
                                    1|a)
                                        find . -iname "index.php" -exec chmod 644 {} \;
                                        find . -iname "index.htm" -exec chmod 644 {} \;
                                        find . -iname "index.html" -exec chmod 644 {} \;
                                    ;;
                                    2|b)
                                        find . -iname "index.php" -exec chmod 444 {} \;
                                        find . -iname "index.htm" -exec chmod 444 {} \;
                                        find . -iname "index.html" -exec chmod 444 {} \;
                                    ;;
                                    *)
                                        echo "";
                                        echo "Le CHMOD des fichiers index (.php .htm .html) n'a pas été modifié.";
                                    ;;
                                esac

                                        # Récupérer la valeur du CHMOD sélectionné :
                                        case $ans in
                                            "1" | "a")
                                                chmodindex="644";
                                            ;;
                                            "2" | "b")
                                                chmodindex="444";
                                            ;;
                                        esac

                                    echo "";
                                    echo "Le CHMOD $chmodindex a été appliqué sur les fichiers index.php index.htm index.html.";

                    else
                        echo "";
                        echo "Le CHMOD des fichiers index.php index.htm index.html n'a pas été modifié.";
                    fi
                sleep 2;
                echo "";

            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac
        
######
        
        # Appliquer la modification de CHMOD pour le CMS identifié :
        case $cms in
            "1" | "j" | "J" | "2" | "m" | "M" | "3" | "w" | "W")
                # echo "La condition vaut pour tous les CMS.";

                # Appliquer le CHMOD recommandé aux fichiers .htaccess, .htaccess* :
                clear
                echo "########################################################";
                sleep 1;
                echo "# Appliquer le CHMOD recommandé aux fichiers .htaccess #"
                sleep 2;
                echo "########################################################";
                sleep 2;
                echo "";
                echo "Le CHMOD des fichiers .htaccess et .htaccess* sera modifié.";
                echo "Le CHMOD des fichiers .htpasswd et .htpasswd* sera également modifié.";
                echo "Utiliser 444 est cohérent.";
                echo "Utiliser 400 permet une sécurité plus poussée.";
                echo "";
                echo "Appuyer sur 'o' pour sélectionner le CHMOD a appliquer.";
                echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                read -r answer;
                    if [ "$answer" != "${answer#[Oo]}" ];
                    then

                        # Appliquer le CHMOD 640 440 400 :
                        echo "";
                        echo "Appliquer le CHMOD 444 aux fichiers .htaccess* avec la touche 1 ou a.";
                        echo "Appliquer le CHMOD 400 aux fichiers .htaccess* avec la touche 2 ou b.";
                        echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                            read -r ans;
                                case $ans in
                                    1|a)
                                        find . -iname ".htaccess*" -exec chmod 444 {} \;
                                        find . -iname ".htpasswd*" -exec chmod 444 {} \;
                                    ;;
                                    2|b)
                                        find . -iname ".htaccess*" -exec chmod 400 {} \;
                                        find . -iname ".htpasswd*" -exec chmod 400 {} \;
                                    ;;
                                    *)
                                        echo "";
                                        echo "Le CHMOD des fichiers .htaccess* n'a pas été modifié.";
                                        echo "Le CHMOD des fichiers .htpasswd* n'a pas été modifié.";
                                    ;;
                                esac

                                        # Récupérer la valeur du CHMOD sélectionné :
                                        case $ans in
                                            "1" | "a")
                                                chmodhtaccess="444";
                                            ;;
                                            "2" | "b")
                                                chmodhtaccess="400";
                                            ;;
                                        esac

                                    echo"";
                                    echo "Le CHMOD $chmodhtaccess a été appliqué sur les fichiers .htaccess*.";
                                    echo "Le CHMOD $chmodhtaccess a été appliqué sur les fichiers .htpasswd*.";

                    else
                        echo "";
                        echo "Le CHMOD des fichiers .htaccess* n'a pas été modifié.";
                        echo "Le CHMOD des fichiers .htpasswd* n'a pas été modifié.";
                    fi
                sleep 2;
                echo "";

            # Fin du choix de CMS.
            ;;
        # Fin de la modification.
        esac
        
######

        # ######

        # Ajouter une modification de CHMOD :
        
        # Appliquer la modification de CHMOD pour le CMS identifié :
        # case $cms in
        #    "1" | "j" | "J" | "3" | "w" | "W")
        #        # echo "La condition vaut pour Joomla et WordPress";

                # Appliquer les droits par défaut aux dossiers et aux fichiers :
                # clear
                #echo "###################################################################";
                #sleep 1;
                #echo -n "#  Les valeurs recommandées du CHMOD seront appliqués par défaut  #"
                #echo "";
                #sleep 2;
                #echo "# Il est conseillé d'utiliser le CHMOD 755 pour tous les dossiers #"
                #sleep 2;
                #echo "# Il est conseillé d'utiliser le CHMOD 644 pour tous les fichiers #";
                #sleep 2;
                #echo "###################################################################";
                #sleep 2;
                #echo "";
                #echo "Appuyer sur 'O' ou 'o' pour continuer.";
                #echo "Toute autre touche ignore cette étape pour passer à l'étape suivante.";
                #read answer
                #    if [ "$answer" != "${answer#[Oo]}" ];
                #    then
                #        echo "";
                #        echo "Le CHMOD proposé par défaut pour les dossiers et les fichiers a été appliqué.";
                #        find . -type d -exec chmod 755 {} \;
                #        find . -type f -exec chmod 644 {} \;
                #    else
                #        echo "";
                #        echo "Le CHMOD des dossiers et des fichiers n'a pas été modifié.";
                #    fi
                #sleep 1;
                #echo "";

        # Fin du choix de CMS :
        #   ;;
        # Fin de la modification :
        # esac

        # ######

        # Fin de la modification des CHMOD :
        sleep 1;
        echo "Fin des différentes propositions de modification de droits CHMOD.";
        echo "Le programme c'est terminé normalement.";
        exit;

    ############################################
    # Fin du programme pour changer les CHMOD. #
    ############################################ 
    # La confirmation pour lancer le programme pour changer les CHMOD a été refusée.
    else
        sleep 1;
        echo "";
        sleep 1;
        echo "Vous avez décidé de ne pas procéder au changement des droits CHMOD.";
        echo "Le programme a été arrêté sans avoir effectué de modifications.";
        exit;
    fi

