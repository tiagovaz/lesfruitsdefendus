Les fruits défendus
===================
http://lesfruitsdefendus.org

Code pour Les fruits défendus Montréal

PHP Redmine API:
* https://github.com/kbsali/php-redmine-api

Insert PHP Wordpress Plugin:
* http://wordpress.org/plugins/insert-php/

Getting Redmine data in Wordpress:

    [insert_php]
    include '/home/tiago/vendor/autoload.php';
    $client = new Redmine\Client('https://redmine.acaia.ca', 'xxxxxxxxxxxxxxxxxxxxxxx');
    foreach($client->api('project')->all() as $p) print_r ($p);
    [/insert_php]

Event Calendar plugin for Wordpress:
* http://wordpress.org/plugins/amr-ical-events-list/

ICS Calendar export for Redmine:
* https://github.com/thegcat/redmine_ical
