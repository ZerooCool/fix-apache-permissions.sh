#!/bin/bash

#############################################################
# La liste de choix des options affichées dans le menu.
#############################################################
options=("Effectuer une sauvegarde" "Effectuer une restauration" "Sauvegarder les fichiers exemple 1" "Sauvegarder les fichiers exemple 2" "Sauvegarder les fichiers exemple 3" "Sauvegarder les fichiers exemple 4" "Quitter sans rien Sauvegarder / Restaurer")

#############################################################
# Fonction pour préparer l'affichage du menu, ou, d'un message d'erreur.
#############################################################
menu() {
    echo "Le choix des options :"
    for i in ${!options[@]}; do
        printf "%3d%s) %s\r\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then
 echo ""
 echo "$msg"; fi
}

#############################################################
# Permet d'effacer l'écran pour le premier affichage du menu.
#############################################################
clear
echo "############################################################"
echo "# Sauvegarder les fichiers de configuration de son serveur #"
echo "############################################################"
echo ""

#############################################################
# Faire une sélection.
#############################################################
# Le retour à la ligne est voulu dans la variable prompt qui est un message
prompt="
Sélectionner / Déselectionner un choix a valider avec la touche entrée : "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do

#############################################################
# Affiche le dernier état du menu suite à une sélection.
#############################################################
clear
echo "############################################################"
echo "# Sauvegarder les fichiers de configuration de son serveur #"
echo "############################################################"
echo ""

#############################################################
# Interdit les lettres et la touche entrée.
#############################################################
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="# Cette option n'existe pas : '$num'."; continue; }
    ((num--)); msg="Dernière action choisie :
- ${options[num]} a été ${choices[num]:+dé}sélectionné."
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"

#############################################################
# Pour le choix "Quitter", on déselectionne les autres choix.
# On commence à compter à partir de 0.
#############################################################
if [[ "${choices[6]}" ]] && choices[6]="+"
then
[[ "${choices[0]}" ]] && choices[0]=""
[[ "${choices[1]}" ]] && choices[1]=""
[[ "${choices[2]}" ]] && choices[2]=""
[[ "${choices[3]}" ]] && choices[3]=""
[[ "${choices[4]}" ]] && choices[4]=""
[[ "${choices[5]}" ]] && choices[5]=""
# Ainsi de suite pour désactiver toutes nouvelles option.
fi

#############################################################
# Empêche la double sélection.
# Ne pas effectuer une sauvegarde suivie d'une restauration.
#############################################################
# Il faut choisir, soit la sauvegarde, soit la restauration.
# Je n'ai pas trouvé comment rendre le changement 1 > 2 ou 2 > 1 instantané.
# Il faudra resélectionner le choix, après que l'ancien choix ait été décoché.

if [[ "${choices[0]}" ]] && choices[0]="+" && [[ "${choices[1]}" ]] && choices[1]=""
then [[ "${choices[0]}" ]] && choices[0]="" && [[ "${choices[1]}" ]] && choices[1]="+"
# Comment rendre l'action instantanée ?
fi

if [[ "${choices[1]}" ]] && choices[1]="+" && [[ "${choices[0]}" ]] && choices[0]=""
then [[ "${choices[1]}" ]] && choices[1]="" && [[ "${choices[0]}" ]] && choices[0]="+"
# Comment rendre l'action instantanée ?
fi
# Pour autoriser la double sélection : sauvegarde + restauration, commenter tout ce bloc.
#############################################################

done


#############################################################
# Récapitulatif de toutes les actions choisies.
#############################################################
clear
echo "############################################################"
echo "# Sauvegarder les fichiers de configuration de son serveur #"
echo "############################################################"

printf "\r\nToutes les actions choisies :\r\n"; msg=" - Aucun choix n'a été effectué."
for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && { printf " - %s" "${options[i]}"; msg=""; }
done

#############################################################
# Afficher un message d'erreur.
#############################################################
echo "$msg"

#############################################################
# Si aucun choix n'est effectué, relancer le programme :
#############################################################
if [[ $msg = " - Aucun choix n'a été effectué." ]]
then
 printf " \r\n"
 echo "Fin du programme. Aucune sauvegarde / restauration n'a été effectuée.";
else
	# Commencer la sauvegarde si l'option a été sélectionnée :
	if [[ ${choices[0]} != "" ]]
	then
        echo ""
	echo "Démarrage de la sauvegarde ..."
	# Ici, on pourrait voir à appeler des scripts externes si possible, un script par tâche à mener.
	fi

	# Commencer la restauration si l'option a été sélectionnée :
	if [[ ${choices[1]} != "" ]]
	then
	echo "Démarrage de la restauration ..."
	# Ici, on pourrait voir à appeler des scripts externes si possible, un script par tâche à mener.
	fi
fi

#############################################################
# End
#############################################################

# Fin de l'exemple de menu à sélection multiple.
exit


# Note :
#############################################################
# Récupérer chaque choix et effectuer une action.
#############################################################
if [[ ${choices[2]} != "" ]]
then
echo ""
echo "L'action doit maintenant être effectuée."
echo "Cette action correspond au choix numéro 3 - Le choices[2]."
fi

# ...

# Source : https://serverfault.com/questions/144939/multi-select-menu-in-bash-script/1023077#1023077
