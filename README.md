# Nginx web server with Perl CPAN and GeoIP module

This is a minimalist Nginx web server image that includes Perl CPAN and GeoIP module for geolocation using [MaxMind GeoIP database](https://www.maxmind.com/en/geoip2-services-and-databases). You will probably want to use Docker mount volume as `/usr/local/share/GeoIP` and refresh it regularly using the script `/geoipupdate.sh` included in the Docker image.

The image contains `docker-entrypoint.sh` script that honors these environment variables:

- RUNUSER_UID - Numeric UID of the real user so programs are run as non-root user, `runuser` in the container
- RUNUSER_HOME - Home directory of `runuser` in the container. Use a Docker mount volume to persist it.

