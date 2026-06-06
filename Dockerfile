FROM php:8.2-apache

# 1. Install the unzip utility and MySQL database drivers
RUN apt-get update && apt-get install -y unzip \
    && docker-php-ext-install mysqli pdo_mysql

# 2. Set the working web directory
WORKDIR /var/www/html

# 3. Copy your zip file from GitHub into the server
COPY membership_portal.zip .

# 4. Unzip the files and clean up the zip archive
RUN unzip membership_portal.zip && rm membership_portal.zip

# 5. If your zip created a subfolder, move everything out to the web root
RUN if [ -d "membership_portal" ]; then mv membership_portal/* . 2>/dev/null || true; fi

# 6. Expose the standard web port
EXPOSE 80
