#!/bin/bash

# Fonction pour vérifier l'état de la dernière commande
check_command_status() {
    if [ $? -ne 0 ]; then
        echo "Erreur lors de l'exécution : $1"
        exit 1
    fi
}

# Fonction principale pour installer WordPress
install_wordpress() {
    # Mettre à jour la liste des paquets
    echo "Mise à jour des paquets..."
    sudo apt-get update
    check_command_status "Mise à jour des paquets"

    # Installer Apache
    echo "Installation d'Apache..."
    sudo apt-get install -y apache2
    check_command_status "Installation d'Apache"
    sudo systemctl start apache2
    sudo systemctl enable apache2

    # Installer PHP 8.3 et son module Apache
    echo "Installation de PHP 8.3..."
    sudo apt-get install -y software-properties-common
    check_command_status "Installation de software-properties-common"

    if ! grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        sudo add-apt-repository ppa:ondrej/php
        check_command_status "Ajout du dépôt PHP PPA"
    else
        echo "Dépôt PHP PPA déjà ajouté"
    fi

    sudo apt-get update
    sudo apt-get install -y php8.3 libapache2-mod-php8.3 php8.3-mysql
    check_command_status "Installation de PHP 8.3 et des modules"

    # Installer MySQL
    echo "Installation de MySQL..."
    sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
    sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'
    sudo apt-get install -y mysql-server
    check_command_status "Installation de MySQL"

    # Créer une base de données et un utilisateur pour WordPress
    echo "Création de la base de données et de l'utilisateur MySQL pour WordPress..."
    sudo mysql -u root -proot -e "CREATE DATABASE wordpress;"
    check_command_status "Création de la base de données WordPress"
    sudo mysql -u root -proot -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';"
    check_command_status "Création de l'utilisateur WordPress"
    sudo mysql -u root -proot -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
    sudo mysql -u root -proot -e "FLUSH PRIVILEGES;"
    check_command_status "Attribution des privilèges à l'utilisateur WordPress"

    # Installer WordPress
    echo "Téléchargement et installation de WordPress..."
    cd /var/www/html
    if [ ! -f latest.tar.gz ]; then
        #Téléchargement latest
        #sudo wget https://wordpress.org/latest.tar.gz 
        sudo wget -O wordpress.tar.gz https://wordpress.org/wordpress-6.6.2.tar.gz
        check_command_status "Téléchargement de WordPress"
    fi

    sudo tar -xzf wordpress.tar.gz
    sudo cp -r wordpress/* /var/www/html/
    sudo chown -R www-data:www-data /var/www/html/
    sudo find /var/www/html/ -type d -exec chmod 755 {} \;
    sudo find /var/www/html/ -type f -exec chmod 644 {} \;
    check_command_status "Décompression et configuration de WordPress"
    sudo rm -rf wordpress wordpress.tar.gz

    # Configuration du fichier wp-config.php
    echo "Configuration du fichier wp-config.php..."
    sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sudo sed -i "s/database_name_here/wordpress/g" /var/www/html/wp-config.php
    sudo sed -i "s/username_here/wordpress/g" /var/www/html/wp-config.php
    sudo sed -i "s/password_here/password/g" /var/www/html/wp-config.php
    sudo rm /var/www/html/index.html
    check_command_status "Configuration du fichier wp-config.php"

    # Créer et configurer le fichier wordpress.conf pour Apache
    echo "Géneration wordpress.conf..."
    sudo bash -c 'cat > /etc/apache2/sites-available/wordpress.conf <<EOF
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ServerName localhost

        <Directory /var/www/html>
            AllowOverride All
            Require all granted
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>
    EOF'
    check_command_status "Géneration wordpress.conf."

    # Activer le fichier de configuration Apache pour WordPress
    echo "configuration Apache..."
    sudo a2ensite wordpress.conf
    sudo a2enmod rewrite
    check_command_status "configuration Apache"

    # Redémarrer Apache
    echo "Redémarrage d'Apache..."
    sudo systemctl restart apache2
    check_command_status "Redémarrage d'Apache"

    echo "Installation de WordPress terminée avec succès."
}

# Appel de la fonction install_wordpress
echo "Démarrage de l'installation de Wordpress..."
install_wordpress
echo "Fin de l'installation de wordpress..."