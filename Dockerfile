# syntax=docker/dockerfile:1
FROM php:8.3-apache

# Enable Apache mod_rewrite and allow .htaccess to override
RUN a2enmod rewrite \
	&& sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

WORKDIR /var/www/html

# Copy source with proper ownership
COPY --chown=www-data:www-data . /var/www/html

# Ensure _tmp is writable at runtime
RUN mkdir -p /var/www/html/_tmp \
	&& chown -R www-data:www-data /var/www/html/_tmp \
	&& chmod -R 775 /var/www/html/_tmp

EXPOSE 80


