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

- Pour démarrer les machines virtuelles, exécutez `vagrant up` à partir du répertoire du projet.
- Pour provisionner la machine virtuelle avec les scripts de provisionnement, exécutez `vagrant provision` à partir du répertoire du projet.
- Pour arrêter les machines virtuelles, exécutez `vagrant halt` à partir du répertoire du projet.
- Pour détruire les machines virtuelles, exécutez `vagrant destroy` à partir du répertoire du projet.

## Contribution

Les contributions sont les bienvenues ! Veuillez forker le dépôt et soumettre une pull request avec vos modifications.
