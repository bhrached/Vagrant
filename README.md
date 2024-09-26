# Vagrant DevOps

Ce projet contient plusieurs fichiers Vagrant qui installent des outils DevOps pour aider à configurer et gérer des environnements

## Prérequis

- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Commencer

1. Clonez ce dépôt sur votre machine locale.
2. Naviguez jusqu'au répertoire du projet.
3. Exécutez `vagrant up` pour démarrer les machines virtuelles.
4. Pour provisionner la machine virtuelle avec les scripts de provisionnement, exécutez `vagrant provision` à partir du répertoire du projet.

## Structure du projet

- `Vagrantfile` : Le fichier de configuration Vagrant principal.
- `vagrant/` : Contient des fichiers Vagrant supplémentaires pour configurer des machines virtuelles supplémentaires.
- `scripts/` : Contient divers scripts pour configurer l'environnement, y compris les scripts de provisionnement.
- `docs/` : Contient de la documentation pour le projet.

## Utilisation

- Le clé SSH privé existe sous ce chemin : .vagrant/machines/default/virtualbox/private_key

Commandes pour gérer le cycle de vie d'une VM Vagrant
-----------------------------------------------------

*   **Lister l'état des VMs** : `vagrant status`
*   **Démarrer les VMs** : `vagrant up`
*   **Redémarrer une VM** : `vagrant reload`
*   **Arrêter les VMs** : `vagrant halt`
*   **Détruire les VMs** : `vagrant destroy`
*   **Se connecter à une VM via SSH** : `vagrant ssh <nom_de_la_vm>`  
    Exemple : `vagrant ssh wordpress`
*   **Mettre à jour la box de la VM** : `vagrant box update`
*   **Synchroniser les dossiers partagés** : `vagrant rsync`

Commandes pour gérer l'approvisionnement des VMs Vagrant
--------------------------------------------------------

*   **Lancer l'approvisionnement lors du démarrage** : `vagrant up --provision`
*   **Forcer l'approvisionnement sans redémarrer** : `vagrant provision`
*   **Reprovisionner une VM spécifique** : `vagrant provision <nom_de_la_vm>`  
    Exemple : `vagrant provision wordpress`
*   **Démarrer une VM avec un approvisionnement spécifique** : `vagrant up --provision-with <provisioner>`  
    Exemple : `vagrant up --provision-with ansible`
*   **Exécuter une commande shell lors de l'approvisionnement** : `vagrant up --provision --provision-with shell`
*   **Vérifier la configuration d'approvisionnement** : `vagrant ssh -- 'cat /etc/os-release'`

Commandes pour le débogage dans Vagrant
---------------------------------------

*   **Obtenir des informations détaillées lors d'une commande** : `vagrant up --debug`
*   **Obtenir des logs détaillés** : `vagrant global-status --debug`
*   **Afficher les informations système de la VM** : `vagrant ssh -- 'uname -a'`
*   **Vérifier l'état de synchronisation des dossiers partagés** : `vagrant rsync --verbose`
*   **Vérifier les erreurs de réseau** : `vagrant ssh -- 'ifconfig'`
*   **Recharger la configuration réseau** : `vagrant reload --provision`
*   **Afficher les logs de provisioning** : `vagrant ssh -- 'tail -f /var/log/syslog'`

Commandes pour manipuler les VMs dans Vagrant
---------------------------------------------

*   **Se connecter à une VM via SSH** : `vagrant ssh <nom_de_la_vm>`  
    Exemple : `vagrant ssh wordpress`
*   **Exécuter une commande directement sur la VM** : `vagrant ssh <nom_de_la_vm> -- -c '<commande>'`  
    Exemple : `vagrant ssh wordpress -- -c 'uptime'`
*   **Suspendre une VM (mise en pause)** : `vagrant suspend <nom_de_la_vm>`  
    Exemple : `vagrant suspend wordpress`
*   **Reprendre une VM suspendue** : `vagrant resume <nom_de_la_vm>`  
    Exemple : `vagrant resume wordpress`
*   **Synchroniser manuellement les dossiers partagés** : `vagrant rsync <nom_de_la_vm>`
*   **Afficher les ports transférés** : `vagrant port <nom_de_la_vm>`  
    Exemple : `vagrant port wordpress`
*   **Redémarrer une VM** : `vagrant reload <nom_de_la_vm>`  
    Exemple : `vagrant reload wordpress`
*   **Mettre à jour la box de la VM** : `vagrant box update`

Commandes pour gérer les snapshots dans Vagrant
-----------------------------------------------

*   **Créer un snapshot** : `vagrant snapshot save <nom_de_la_vm> <nom_du_snapshot>`  
    Exemple : `vagrant snapshot save wordpress before-update`
*   **Lister les snapshots disponibles** : `vagrant snapshot list <nom_de_la_vm>`
*   **Restaurer un snapshot** : `vagrant snapshot restore <nom_de_la_vm> <nom_du_snapshot>`  
    Exemple : `vagrant snapshot restore wordpress before-update`
*   **Supprimer un snapshot** : `vagrant snapshot delete <nom_de_la_vm> <nom_du_snapshot>`  
    Exemple : `vagrant snapshot delete wordpress before-update`
*   **Prendre un snapshot rapide (sans nom spécifique)** : `vagrant snapshot push`
*   **Restaurer à un snapshot rapide** : `vagrant snapshot pop`

## Contribution

Les contributions sont les bienvenues ! Veuillez forker le dépôt et soumettre une pull request avec vos modifications.

<h2>Auteur</h2>
<p>Ce projet a été développé par bhrached.</p>
<h2>Licence</h2>
<p>Ce projet est sous licence MIT.</p>

