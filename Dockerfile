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

# Create an empty SQLite file inside the container during build if not already existing
RUN if [ ! -f /var/www/database/database.sqlite ]; then touch /var/www/database/database.sqlite; fi

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Clear & cache Laravel config to pick up env changes like APP_ENV=production
RUN php artisan config:clear && php artisan config:cache

# Run migrations (optional if not running on startup)
RUN php artisan migrate --force

# Set Laravel permissions and ensure the database has proper permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www/storage
RUN chown www-data:www-data /var/www/database/database.sqlite && chmod 755 /var/www/database/database.sqlite
RUN chmod -R 777 /var/www/database/database.sqlite

# Expose port
EXPOSE 10000

# Start Laravel
CMD php artisan serve --host=0.0.0.0 --port=10000
