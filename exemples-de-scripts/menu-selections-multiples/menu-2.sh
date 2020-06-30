#!/bin/bash

#############################################################
# Les signaux sont ignorés pour interdire la fin du programme avec CTRL C.
#############################################################
trap "" 2 3 15

#############################################################
# Options du menu :
#############################################################
options[0]="Effectuer une sauvegarde"
options[1]="Effectuer une restauration"
options[2]="-- Crontab de l'utilisateur root"
options[3]="-- Configuration de Apache2"
options[4]="Optimiser les droits CHMOD et CHOWN sur les sites hébergés"
options[5]="Appliquer les choix"
options[6]="Quitter et ne rien faire"

# Choix des actions basées sur la sélection :
function ACTIONS {
    # On commence à compter à partir de 0.
    if [[ ${choices[0]} ]]; then
        # Option 1 sélectionnée :
        echo "Effectuer la sauvegarde a été sélectionné"
    fi
    if [[ ${choices[1]} ]]; then
        # Option 2 sélectionnée :
        echo "Effectuer la restauration a été sélectionné"
    fi
    if [[ ${choices[2]} ]]; then
        # Option 3 sélectionnée :
        echo "- Crontab de l'utilisateur root a été sélectionné"
    fi
    if [[ ${choices[3]} ]]; then
        # Option 4 sélectionnée :
        echo "- Configuration de Apache2 a été sélectionné"
    fi
    if [[ ${choices[4]} ]]; then
        # Option 5 sélectionnée :
        echo "Modifier les droits CHMOD et CHOWN sur les sites hébergés a été sélectionné"
    fi
    if [[ ${choices[5]} ]]; then
        # Option 6 sélectionnée :
        echo "Appliquer a été sélectionné"
    fi
    if [[ ${choices[6]} ]]; then
        # Option 7 sélectionnée :
        echo "Quitter a été sélectionné"
    fi
}

# Variables
MESSAGE="Sélectionner les actions à mener puis confirmer avec Appliquer et entrée."

#############################################################
# Vider l'écran lors du premier affichage du menu :
#############################################################
clear

#############################################################
# Menu function :
#############################################################
function MENU {
    #############################################################
    # Permet d'effacer l'écran pour le premier affichage du menu.
    #############################################################
    clear
    echo "##########################################"
    echo "# Maintenance des données sur le serveur #"
    echo "##########################################"
    echo ""

        for NUM in ${!options[@]}; do
            echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
        done
        echo ""
        echo "$MESSAGE"
}

#############################################################
# Début de la boucle sur le menu pour cocher et décocher les choix.
#############################################################
while MENU && read -e -p "Choisir les options avec des chiffres et valider avec la touche entrée : " -n2 SELECTION && [[ -n "$SELECTION" ]];
do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))

	#############################################################
	# Afficher le choix de la sélection. 
	#############################################################
	MESSAGE="${options[SELECTION]} a été ${choices[SELECTION]:+dé}sélectionné."

        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
    else
        MESSAGE="Le choix '$SELECTION' est une option invalide !"
    fi

#############################################################
# Empêche la double sélection.
# Ne pas effectuer une sauvegarde suivie d'une restauration.
# Il faut choisir, soit la sauvegarde, soit la restauration.
# Pour autoriser la double sélection : sauvegarde + restauration, commenter ce bloc.
#############################################################
if [[ "${choices[0]}" ]] && choices[0]="+" && [[ "${choices[1]}" ]] && choices[1]=""
then [[ "${choices[0]}" ]] && choices[0]="" && [[ "${choices[1]}" ]] && choices[1]="+"
fi
if [[ "${choices[1]}" ]] && choices[1]="+" && [[ "${choices[0]}" ]] && choices[0]=""
then [[ "${choices[1]}" ]] && choices[1]="" && [[ "${choices[0]}" ]] && choices[0]="+"
fi

#############################################################
# Choisir à nouveau autre chose que le choix "Quitter".
# Ainsi de suite pour désactiver toutes les nouvelles option.
#############################################################
if [[ "${choices[0]}" ]] && choices[0]="+" && [[ "${choices[6]}" ]] && choices[6]=""
then
[[ "${choices[0]}" ]] && choices[0]="" && [[ "${choices[6]}" ]] && choices[6]=""
choices[1]=""
choices[2]=""
choices[3]=""
choices[4]=""
choices[5]=""
MESSAGE="Confirmer à nouveau l'arrêt du programme avec le choix 7 !"
fi

if [[ "${choices[1]}" ]] && choices[1]="+" && [[ "${choices[6]}" ]] && choices[6]=""
then
choices[0]=""
[[ "${choices[1]}" ]] && choices[1]="" && [[ "${choices[6]}" ]] && choices[6]=""
choices[2]=""
choices[3]=""
choices[4]=""
choices[5]=""
MESSAGE="Confirmer à nouveau l'arrêt du programme avec le choix 7 !"
fi

if [[ "${choices[2]}" ]] && choices[2]="+" && [[ "${choices[6]}" ]] && choices[6]=""
then
choices[0]=""
choices[1]=""
[[ "${choices[2]}" ]] && choices[2]="" && [[ "${choices[6]}" ]] && choices[6]=""
choices[3]=""
choices[4]=""
choices[5]=""
MESSAGE="Confirmer à nouveau l'arrêt du programme avec le choix 7 !"
fi

if [[ "${choices[3]}" ]] && choices[3]="+" && [[ "${choices[6]}" ]] && choices[6]=""
then
choices[0]=""
choices[1]=""
choices[2]=""
[[ "${choices[3]}" ]] && choices[3]="" && [[ "${choices[6]}" ]] && choices[6]=""
choices[4]=""
choices[5]=""
MESSAGE="Confirmer à nouveau l'arrêt du programme avec le choix 7 !"
fi

if [[ "${choices[4]}" ]] && choices[4]="+" && [[ "${choices[6]}" ]] && choices[6]=""
then
choices[0]=""
choices[1]=""
choices[2]=""
choices[3]=""
[[ "${choices[4]}" ]] && choices[4]="" && [[ "${choices[6]}" ]] && choices[6]=""
choices[5]=""
MESSAGE="Confirmer à nouveau l'arrêt du programme avec le choix 7 !"
fi

if [[ "${choices[5]}" ]] && choices[5]="+" && [[ "${choices[6]}" ]] && choices[6]=""
then
choices[0]=""
choices[1]=""
choices[2]=""
choices[3]=""
choices[4]=""
[[ "${choices[5]}" ]] && choices[5]="" && [[ "${choices[6]}" ]] && choices[6]=""
MESSAGE="Confirmer à nouveau l'arrêt du programme avec le choix 7 !"
fi

#############################################################
# Pour le choix "Quitter", on déselectionne les autres choix.
# Ainsi de suite pour désactiver toutes les nouvelles option.
#############################################################
if [[ "${choices[6]}" == "+" ]]; then
choices[0]=""
choices[1]=""
choices[2]=""
choices[3]=""
choices[4]=""
choices[5]=""
MESSAGE="Confirmer l'arrêt du programme avec la touche entrée ou changer de choix."
fi

#############################################################
# Fin de la boucle while pour les choix du menu.
#############################################################
done

#############################################################
# Récapitulatif de toutes les actions choisies.
#############################################################
clear
echo "############################################################"
echo "# Sauvegarder les fichiers de configuration de son serveur #"
echo "############################################################"
printf "\r\nLes choix suivants ont été sélectionnés :\r\n"; MESSAGE=" - Aucun choix n'a été effectué."
for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && { printf " - %s\r\n" "${options[i]}"; MESSAGE=""; }
done

#############################################################
# Fin du programme. Aucun choix n'a été effectué :
#############################################################
if [[ $MESSAGE = " - Aucun choix n'a été effectué." ]]
then
 MESSAGE=" - Aucun choix n'a été effectué."
 echo "$MESSAGE"
 echo
 echo "Fin du programme. Aucune modification n'a été effectuée sur le système.";
 exit
fi

#############################################################
# Arrêter les actions si le choix sauvegarder / restaurer n'a pas été sélectionné :
#############################################################
# Exception dans le cas ou seul la maintenance des droits CHMOD / CHOWN est demandée.
if [[ ${choices[4]} != "" ]]
then
 MESSAGE=""
else

if [[ ${choices[0]} = "" && ${choices[1]} = "" ]]
then
 MESSAGE="Préciser si l'action doit concerner une sauvegarde ou une restauration !"
 echo
 echo "$MESSAGE"
 echo
 echo "Fin du programme. Aucune modification n'a été effectuée sur le système.";
exit;
fi

fi

#############################################################
# Arrêter les actions si aucune sous options n'a été choisie :
#############################################################
# Exception dans le cas ou seul la maintenance des droits CHMOD / CHOWN est demandée.
if [[ ${choices[4]} != "" ]]
then
 MESSAGE=""
else

if [[ ${choices[2]} = "" && ${choices[3]} = "" ]]
then
 MESSAGE="Préciser les services à sauvegarder ou a restaurer !"
 echo
 echo "$MESSAGE"
 echo
 echo "Fin du programme. Aucune modification n'a été effectuée sur le système.";
exit;
fi

fi

#############################################################
# Arrêter les actions si le choix Appliquer n'a pas été sélectionné :
#############################################################
if [[ ${choices[5]} = "" ]]
then
 MESSAGE="'Merci de confirmer les actions avec le choix '6) Appliquer' !"
 echo
 echo "$MESSAGE"
 echo
 echo "Fin du programme. Aucune modification n'a été effectuée sur le système.";
exit;
fi

#############################################################
# Afficher un message :
#############################################################
echo "$MESSAGE"

#############################################################
# Fin de l'affichage des choix du menu.
#############################################################

###########
###########
# ACTIONS #
###########
###########

# Commencer la sauvegarde si l'option a été sélectionnée :
if [[ ${choices[0]} != "" ]]
then
	MESSAGE="Démarrage de la sauvegarde ..."
	# Ici, on pourrait voir à appeler des scripts externes si possible, un script par tâche à mener.
fi

# Commencer la restauration si l'option a été sélectionnée :
if [[ ${choices[1]} != "" ]]
then
	MESSAGE="Démarrage de la restauration ..."
	# Ici, on pourrait voir à appeler des scripts externes si possible, un script par tâche à mener.
fi

# Démarrage de la configuration des CHMOD / CHOWN :
if [[ ${choices[4]} != "" ]]
then
	echo "Faire une sauvegarde est recommandée avant de modifier les droits CHMOD/CHOWN."
	echo ""
	MESSAGE="Démarrage de la configuration des CHMOD / CHOWN."
	# Ici, on pourrait voir à appeler des scripts externes si possible, un script par tâche à mener.
fi

#############################################################
# Afficher un message :
#############################################################
echo "#############"
echo "# $MESSAGE"
echo "#############"

#############################################################
# Les signaux sont ignorés pour interdire la fin du programme avec CTRL C.
#############################################################
trap 2 3 15

#############################################################
# End
#############################################################
# Fin de l'exemple de menu à sélection multiple.
exit
#############################################################
