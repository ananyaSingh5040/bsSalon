FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    sqlite3 \
    libsqlite3-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy app files
COPY . .

# Ensure database directory & file exists
RUN mkdir -p database && \
    touch database/database.sqlite && \
    chmod -R 777 database

# Set correct permissions
RUN chown -R www-data:www-data /var/www

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose Laravel’s internal dev server port
EXPOSE 8080

# Start Laravel built-in dev server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
