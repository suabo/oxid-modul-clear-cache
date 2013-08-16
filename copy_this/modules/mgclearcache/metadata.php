<?php

/**
 * Metadata version
 */
$sMetadataVersion = '1.1';

/**
 * Module information
 */
$aModule = array(
    'id'          => 'mgclearcache',
    'title'       => 'Clear Cache',
    'description' => 'Clear Cache Button',
    'thumbnail'   => 'logo.jpg',
    'version'     => '1.1',
    'author'      => 'suabo',
    'url'         => 'http://www.suabo.de',
    'email'       => 'info@suabo.de',
    'extend'      => array(
        //''        => '',
    ),
    'files'          => array(
        'mgclearcache' => 'mgclearcache/controllers/admin/mgclearcache.php',
    ),
    'blocks'                              => array(
        array('template' => 'header.tpl', 'block'    => 'header_buttons', 'file'     => 'views/blocks/mgclearcachebutton.tpl'),
    ),
    'templates' => array(
        'mgclearcachepopup.tpl'                 => 'mgclearcache/views/admin/tpl/mgclearcachepopup.tpl',
    ),
);