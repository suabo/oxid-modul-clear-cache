<?php
/**
 * Metadata version
 */
$sMetadataVersion = '1.1';

/**
 * Module information
 */
$aModule = array(
    'id'          => 'suaboclearcache',
    'title'       => 'Clear Cache',
    'description' => array(
      'de' => 'Modul um die temporären Shopverzeichnise zu leeren.',
      'en' => 'Clear Shopcache in admin backend.'
    ),
    'thumbnail'   => '../logo.png',
    'version'     => '1.1.6',
    'author'      => 'suabo',
    'url'         => 'http://www.suabo.de',
    'email'       => 'info@suabo.de',
    'extend' => array( ),
    'files' => array(
        'mgclearcache' => 'suabo/clearcache/controllers/admin/mgclearcache.php',
    ),
    'blocks' => array(
        array('template' => 'header.tpl', 'block' => 'header_buttons', 'file' => 'views/blocks/mgclearcachebutton.tpl'),
    ),
    'templates' => array(
        'mgclearcachepopup.tpl' => 'suabo/clearcache/views/admin/tpl/mgclearcachepopup.tpl',
        'mgclearcache.tpl' => 'suabo/clearcache/views/admin/tpl/mgclearcache.tpl',
    ),
);
