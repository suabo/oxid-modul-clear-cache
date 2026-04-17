<?php
/**
 * Metadata version
 */
$sMetadataVersion = '2.1';

/**
 * Module information
 */
$aModule = array(
    'id'          => 'suaboclearcache',
    'title'       => 'suabo: Clear Cache',
    'description' => array(
      'de' => 'Stellt verschiedene Shop Cache Informationen bereit und bietet die möglichkeit diesen aus dem Backend zu leeren.',
      'en' => 'Get cache information and clear shop cache from within admin backend.'
    ),
    'thumbnail'   => './logo.png',
    'version'     => '4.0.0',
    'author'      => 'Marcel Grolms',
    'url'         => 'https://www.suabo.de',
    'email'       => 'info@suabo.de',
    'extend' => array(),
    'controllers' => array(
        'suaboclearcache' => \Suabo\ClearCache\Controller\Admin\ClearCache::class
    ),
    'blocks' => array(
        [
            'template' => 'include/header_links.tpl',
            'block' => 'admin_header_links',
            'file' => 'views/admin_smarty/blocks/suaboclearcachebutton.tpl'
        ]
    ),
    'templates' => array(
        'suaboclearcache_popup.tpl' => '@suaboclearcache/views/admin_smarty/tpl/suaboclearcache_popup.tpl',
        'suaboclearcache.tpl' => '@suaboclearcache/views/admin_smarty/tpl/suaboclearcache.tpl'
    ),
    'settings' => array(
        array('group' => 'SUABOCLEARCACHE_main', 'name' => 'blSuaboClearCacheMode', 'type' => 'select', 'value' => '0', 'constraints' => '0|1', 'position' => 0),
        array('group' => 'SUABOCLEARCACHE_main', 'name' => 'blSuaboClearCacheShop', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'SUABOCLEARCACHE_main', 'name' => 'blSuaboClearCachePersShop', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'SUABOCLEARCACHE_main', 'name' => 'blSuaboClearCacheTpl', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'SUABOCLEARCACHE_main', 'name' => 'blSuaboClearCacheLang', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'SUABOCLEARCACHE_main', 'name' => 'blSuaboClearCacheMenu', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'SUABOCLEARCACHE_debug', 'name' => 'blSuaboPHPErrorLogPath', 'type' => 'str', 'value' => '/path/to/your/php/error.log')
    )
);