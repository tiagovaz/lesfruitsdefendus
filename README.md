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
* https://github.com/thegcat/redmine_ical (using a modified version, 'forked' here.)

Maps plugin for Wordpress:
* http://wordpress.org/plugins/comprehensive-google-map-plugin/installation/

Short code sample for drawing a map:

    [google-map-v3 shortcodeid="TO_BE_GENERATED" width="350" height="350" zoom="12" maptype="OSM" mapalign="center" directionhint="false" language="default" poweredby="false" maptypecontrol="true" pancontrol="true" zoomcontrol="true" scalecontrol="true" streetviewcontrol="true" scrollwheelcontrol="false" draggable="true" tiltfourtyfive="false" enablegeolocationmarker="false" enablemarkerclustering="false" addmarkermashup="false" addmarkermashupbubble="false" addmarkerlist="45.5, -73.566667{}7-default.png{}montreal|48.5, -63.566667{}cloudysunny.png{}montreal 2" bubbleautopan="true" distanceunits="km" showbike="false" showtraffic="false" showpanoramio="false"]

