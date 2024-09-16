#!/bin/bash

# install_gitlab.sh
# Script pour installer gitlab sur une machine Ubuntu 22

# Activer le mode strict
set -euo pipefail

# Fonction pour installer et configurer GitLab
install_gitlab() {
    # Instalation Open SSH
    sudo apt-get update
    sudo apt-get install -y curl openssh-server ca-certificates

    # Installer gitlab
    curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
    sudo EXTERNAL_URL="http://$(hostname -I | awk '{print $1}')" apt-get install -y gitlab-ce

    # Afficher le mot de passe initial de l'administrateur GitLab
    echo "GitLab est installé. URL : http://localhost:8091"
    echo "Mot de passe initial de l'administrateur :"
    sudo cat /etc/gitlab/initial_root_password
}

# Script principal
echo "Démarrage de l'installation de Gitlab..."
install_gitlab
echo "Installation de GitLab terminée."