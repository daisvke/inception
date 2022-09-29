#!/bin/bash

function wait_for_db()
{
	until mysql --host=mariadb --user=$MARIADB_USER --password=$MARIADB_PWD -e '\c'; do
		echo >&2 "Waiting for mariadb to be ready..."
		sleep 1
	done
}

function generate_posts()
{
	wp post create --post_status=publish --post_category=Japanese --post_title="Shoyu Ramen #1" \
		--post_content="[gallery ids='$(wp media import /tmp/img/r1.jpg --porcelain)' size='full'] \
		<p align='center'>Ramen soupe à base de sauce soja et de graisse de canard avec chashu, œuf mariné ajitama, menma, \
		feuille d'algue, poireau, pousses de soja et ciboulette</p>"
	wp post create --post_status=publish --post_category=Italian --post_title="Tagliatelles à la truffe" \
	--post_content="[gallery ids='$(wp media import /tmp/img/p1.jpg --porcelain)' size='full'] \
		<p align='center'>Tagliatelles au parmesan et à la truffe de saison</p>"
	wp post create --post_status=publish --post_category=Japanese --post_title="Kamo Ramen" \
	--post_content="[gallery ids='$(wp media import /tmp/img/r2.jpg --porcelain)' size='full'] \
		<p align='center'>Ramen soupe à base de sauce soja et de graisse de canard avec magret de canard, œuf mariné ajitama, \
		menma, feuille d'algue, beurre, poireau, pousses de soja et ciboulette</p>"
	wp post create --post_status=publish --post_category=Italian --post_title="Tagliatelles au pesto et jambon de parme" \
		--post_content="[gallery ids='$(wp media import /tmp/img/p2.jpg --porcelain)' size='full'] \
		<p align='center'>Tagliatelles à la sauce pesto, avec truffe de saison, jambon de parme 36 mois AOP, pigons de pin, \
		tomates cerise et feuilles de basilic"
	wp post create --post_status=publish --post_category=Japanese --post_title="Glace vanille à la truffe</p>" \
	--post_content="[gallery ids='$(wp media import /tmp/img/ice.jpg --porcelain)' size='full'] \
		<p align='center'>Glace parfum vanille enveloppée de truffe râpée de saison</p>"
	wp post create --post_status=publish --post_category=Japanese --post_title="Shoyu Ramen #2" \
		--post_content="[gallery ids='$(wp media import /tmp/img/r3.jpg --porcelain)' size='full'] \
		<p align='center'>Ramen soupe à base de sauce soja et de graisse de canard avec chashu, œuf mariné ajitama, menma, \
		feuille d'algue, beurre, poireau et ciboulette</p>"
	wp post create --post_status=publish --post_category=Italian --post_title="Tagliatelles au pesto et aux crevettes" \
		--post_content="[gallery ids='$(wp media import /tmp/img/p3.jpg --porcelain)' size='full'] \
		<p align='center'>Tagliatelles à la sauce pesto, aux crevettes et feuilles de basilic</p>"
	wp post create --post_status=publish --post_category=Japanese --post_title="Chashu Don" \
		--post_content="[gallery ids='$(wp media import /tmp/img/chashu.jpg --porcelain)' size='full'] \
		<p align='center'>Chashu Don à la sauce spéciale du chef</p>"
	wp post create --post_status=publish --post_category=Japanese --post_title="Chirashi au thon jaune et groseilles" \
		--post_content="[gallery ids='$(wp media import /tmp/img/chirashi.jpg --porcelain)' size='full'] \
		<p align='center'>Chirashi au thon albacore et aux groseilles avec mayonnaise au mentaiko, sauce soja à la truffe, \
		riz au vinaigre de vin rouge, oignon rouge, et ciboulette</p>"
	wp post create --post_status=publish --post_category=Japanese --post_title="Nigirizushi au thon jaune et groseilles" \
		--post_content="[gallery ids='$(wp media import /tmp/img/nigiri.jpg --porcelain)' size='full'] \
		<p align='center'>Nigirizushi au thon albacore et aux groseilles, riz au vinaigre de vin rouge, feuilles d'or, \
		et sauce soja à la truffe</p>"
}

if [ ! -f "wp-config.php" ]; then
	cp /config/wp-config ./wp-config.php
	# Only continue if mariadb is ready
	wait_for_db
	# Configure wordpress website
	wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" \
    	--admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email
	wp plugin update --all
	# Install theme
	wp theme install twentytwentytwo --activate
	# Create user
	wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PWD
	# Delete default "Hello World" post
	wp post delete 1
	# Create new categories
	wp term create category Japanese --description="Japanese dishes"
	wp term create category Italian --description="Italian dishes"
	# Create posts with pictures
	generate_posts
fi

php-fpm7 --nodaemonize