#!/bin/bash

# install_jenkins.sh
# Script pour installer Jenkins sur une machine Ubuntu 22

# Activer le mode strict
set -euo pipefail

# Fonction pour installer et configurer Jenkins
install_jenkins() {
    local JENKINS_KEY_URL="https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key"
    local JENKINS_REPO_URL="https://pkg.jenkins.io/debian-stable binary/"

    # Mettre à jour la date
    echo "Mise à jour de la date..."
    sudo apt-get install -y ntpdate
    sudo ntpdate ntp.ubuntu.com

    # Mettre à jour les listes de paquets
    echo "Mise à jour des listes de paquets..."
    sudo apt-get update --fix-missing
    sudo apt-get clean
    sudo apt-get update

    # Installer les dépendances
    echo "Installation des dépendances..."
    sudo apt-get install -y fontconfig openjdk-17-jre

    # Ajouter la clé du dépôt Jenkins
    echo "Ajout de la clé du dépôt Jenkins..."
    sudo wget -q -O /usr/share/keyrings/jenkins-keyring.asc "$JENKINS_KEY_URL"

    # Ajouter le dépôt Jenkins
    echo "Ajout du dépôt Jenkins..."
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] $JENKINS_REPO_URL" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Mettre à jour les listes de paquets
    echo "Mise à jour des listes de paquets..."
    sudo apt-get update

    # Installer Jenkins
    echo "Installation de Jenkins..."
    sudo apt-get install -y jenkins

    # Démarrer et activer le service Jenkins
    echo "Démarrage et activation du service Jenkins..."
    sudo systemctl start jenkins
    sudo systemctl enable jenkins > /dev/null

    # Afficher le statut de Jenkins
    echo "Statut de Jenkins :"
    sudo systemctl status jenkins

    # Afficher le mot de passe initial de l'administrateur Jenkins
    echo "Jenkins est installé. URL : http://localhost:8081"
    echo "Mot de passe initial de l'administrateur :"
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
}

# Script principal
echo "Démarrage de l'installation de Jenkins..."
install_jenkins
echo "Installation de Jenkins terminée."