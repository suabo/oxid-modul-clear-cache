<?php

namespace Suabo\ClearCache\Controller\Admin;

use OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController;
use OxidEsales\Eshop\Core\Module\Module;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\UtilsView;

/**
 * Class ClearCache
 */
class ClearCache extends AdminDetailsController {

    /**
     * Template
     * @var string
     */
    protected $_sThisTemplate = "suaboclearcache.tpl";

    /**
     * Clear cache object
     * @var null|\stdClass
     */
    protected $_oClearCache = null;

    /**
     * Debug object
     * @var null
     */
    protected $_oDebug = null;

    /**
     * Render Tempalte
     * @return string
     */
    public function render() {
        $this->_aViewData['aSettings'] = $this->_loadSettings();
        $this->_aViewData['oClearCache'] = $this->_getCacheInfo();
        $this->_aViewData['oDebug'] = $this->_getDebugInfo();

        return parent::render();
    }

    /**
     * Save Settings
     */
    public function saveSetting() {
        $aMapping = array(
            'shop'      => 'blSuaboClearCacheShop',
            'persshop'  => 'blSuaboClearCachePersShop',
            'tpl'       => 'blSuaboClearCacheTpl',
            'lang'      => 'blSuaboClearCacheLang',
            'menu'      => 'blSuaboClearCacheMenu',
        );

        $oConfig = Registry::getConfig();
        $oRequest = Registry::getRequest();
        $sName = $oRequest->getRequestParameter('name');
        $sValue = $oRequest->getRequestParameter('value');
        $iMode = $oRequest->getRequestParameter('mode');
        $oConfig->saveShopConfVar('bool', $aMapping[$sName], $sValue, $oConfig->getShopId(), 'module:suaboclearcache');
        $oConfig->saveShopConfVar('bool', 'blSuaboClearCacheMode', $iMode, $oConfig->getShopId(), 'module:suaboclearcache');

        // debug msg
        echo $aMapping[$sName].' saved with value '.$sValue;

        exit(1);
    }

    /**
     * Load settings
     * @return array
     */
    protected function _loadSettings() {
        $aUserSettings = array();
        $oConfig = $this->getConfig();
        $aUserSettings['mode'] = $oConfig->getConfigParam('blSuaboClearCacheMode');
        $aUserSettings['shop'] = $oConfig->getConfigParam('blSuaboClearCacheShop');
        $aUserSettings['persshop'] = $oConfig->getConfigParam('blSuaboClearCachePersShop');
        $aUserSettings['tpl'] = $oConfig->getConfigParam('blSuaboClearCacheTpl');
        $aUserSettings['lang'] = $oConfig->getConfigParam('blSuaboClearCacheLang');
        $aUserSettings['menu'] = $oConfig->getConfigParam('blSuaboClearCacheMenu');
        return $aUserSettings;
    }

    /**
     * get debug infos
     * @return null|\stdClass
     */
    protected function _getDebugInfo() {
        $oConfig = $this->getConfig();
        if($this->_oDebug === null) {
            $this->_oDebug = new \stdClass();
        }

        // check php error log
        $sPHPErrorLogPath = $oConfig->getConfigParam('blSuaboPHPErrorLogPath');
        if(file_exists($sPHPErrorLogPath)) {
            $this->_oDebug->sPHPErrorLog = true;
            $this->_oDebug->sPHPErrorLogPath = $sPHPErrorLogPath;
            $this->_oDebug->sPHPErrorLogSize = $this->_getFileSize($sPHPErrorLogPath);
        } else {
            //try to get the path from php setttings
            $sPHPErrorLogPath = ini_get('error_log');
            if(!empty($sPHPErrorLogPath)) {
                $this->_oDebug->sPHPErrorLogPath = $sPHPErrorLogPath;
                if(file_exists($sPHPErrorLogPath)) {
                    $this->_oDebug->sPHPErrorLog = true;
                    $this->_oDebug->sPHPErrorLogSize = $this->_getFileSize($sPHPErrorLogPath);
                } else {
                    $this->_oDebug->sPHPErrorLogSize = "SUABOCLEARCACHE_ERROR_PHP_FILE_SIZE";
                }
            }
        }

        // get tail of php error log
        if(file_exists($sPHPErrorLogPath)) {
            $fh = fopen($sPHPErrorLogPath, 'r');
            fseek($fh, filesize($sPHPErrorLogPath) - 4096);
            $this->_oDebug->sPHPErrorLogTail = fread($fh, 4096);
            $this->_oDebug->sPHPErrorLogTail = substr($this->_oDebug->sPHPErrorLogTail, strpos($this->_oDebug->sPHPErrorLogTail, "\n"));
            fclose($fh);
        }

        // check exception log
        $sLogPath = $oConfig->getConfigParam('sShopDir')."log/oxideshop.log";
        if(file_exists($sLogPath)) {
            $this->_oDebug->sShopLogPath = $sLogPath;
            $this->_oDebug->sShopLogFileSize = $this->_getFileSize($sLogPath);
        } else {
            $this->_oDebug->sShopLogPath = "oxideshop.log wurde nicht gefunden!";
        }

        // get tail of exception log
        $fh = fopen($sLogPath, 'r');
        fseek($fh, filesize($sLogPath) - 4096);
        $this->_oDebug->sExceptionLogTail = fread($fh, 4096);
        $this->_oDebug->sExceptionLogTail = substr($this->_oDebug->sExceptionLogTail, strpos($this->_oDebug->sExceptionLogTail, "\n"));
        fclose($fh);
        return $this->_oDebug;
    }

    /**
     * Get file size of file via path
     * @param $sFilename
     * @return mixed
     */
    protected function _getFileSize($sFilename) {
        $iBytes = filesize($sFilename);
        return $this->_formatHumanFileSize($iBytes);
    }

    /**
     * Format file size into human readable format
     * @param $iBytes
     * @return mixed
     */
    protected function _formatHumanFileSize($iBytes) {
        $sz = 'BKMGTP';
        $factor = floor((strlen($iBytes) - 1) / 3);
        return str_replace(array('B', 'K', 'M', 'G', 'T', 'P'), array('Byte', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb'), sprintf("%.2f", $iBytes / pow(1024, $factor)).' '.@$sz[intval($factor)]);
    }

    /**
     * get cache information
     * @return null|\stdClass
     */
    protected function _getCacheInfo() {
        $oConfig = Registry::getConfig();
        // init response object
        if($this->_oClearCache === null) {
            $this->_oClearCache = new \stdClass();
        }

        // get shop cache dir
        $sCacheDir = $oConfig->getConfigParam('sCompileDir');

        // get all cache files array
        $aCache = $this->_getAllCacheFiles();
        // set total cache file count
        $this->_oClearCache->iFileCount = count($aCache);

        // check file size of cache
        $sDuRes = exec('du --summarize '.$sCacheDir.'/');
        $iCacheBytes = substr($sDuRes, 0, strpos($sDuRes, $sCacheDir));
        $this->_oClearCache->iFileSize = $this->_formatHumanFileSize($iCacheBytes);

        // check for htaccess file
        $this->_oClearCache->isHtaccess = file_exists($sCacheDir.'/.htaccess');
        // get cache dir
        $this->_oClearCache->sCachePath = $oConfig->getConfigParam('sCompileDir');
        // get smarty dir
        $this->_oClearCache->sSmartyCachePath = Registry::get(UtilsView::class)->getSmartyDir();

        return $this->_oClearCache;
    }

    /**
     * Clear cache as user selected
     */
    public function clearCache() {
        if($this->_oClearCache === null) {
            $this->_oClearCache = new \stdClass();
        }

        $oRequest = Registry::getRequest();
        $oUtils = Registry::getUtils();
        $aClearCache = $oRequest->getRequestParameter('clearcache');
        if(empty($aClearCache) || !is_array($aClearCache)) {
            // load saved vars to perform cache clear if we got no post settings
            $aClearCache = $this->_loadSettings();
        }
        $this->_oClearCache->aSettings = array();

        // check for clearing mode
        $this->_oClearCache->iMode = $aClearCache['mode'];
        if($aClearCache['mode'] == 0) {
            // clear all cache files
            $aCache = $this->_getAllCacheFiles();
            foreach($aCache as $sFile) {
                // remove cache file if no folder
                if(!is_dir($sFile) && @unlink($sFile)) {
                    if(!is_array($this->_oClearCache->aDeletedCacheFiles)) {
                        $this->_oClearCache->aDeletedCacheFiles = array();
                    }
                    // append file to log array
                    $this->_oClearCache->aDeletedCacheFiles[] = $sFile;
                }
            }

            $this->_oClearCache->iDeletedCacheFileCnt = count($this->_oClearCache->aDeletedCacheFiles);

        } else {
            // clear shop cache
            if($aClearCache['shop']) {
                $this->_oClearCache->aSettings['Shop'] = true;
                $oUtils->oxResetFileCache();
            }
            // clear persistent shop cache
            if($aClearCache['persshop']) {
                $this->_oClearCache->aSettings['Persistent'] = true;
                $this->_resetPersistentCache();
            }
            // clear tpl cache
            if($aClearCache['tpl']) {
                $this->_oClearCache->aSettings['Template'] = true;
                $this->_resetTemplateCache();
            }
            // clear language cache
            if($aClearCache['lang']) {
                $this->_oClearCache->aSettings['Language'] = true;
                $oUtils->resetLanguageCache();
            }
            // clear menu cache
            if($aClearCache['menu']) {
                $this->_oClearCache->aSettings['Menu'] = true;
                $oUtils->resetMenuCache();
            }
        }

        $this->_aViewData["blCacheCleared"] = true;

        // check htaccess
        if(!$this->_oClearCache->isHtaccess) {
            $this->createHtaccessFile();
        }
    }

    /**
     * Clear template cache
     */
    protected function _resetTemplateCache() {
        // get all template cache files
        $aTplCacheFiles = glob(Registry::get(UtilsView::class)->getSmartyDir().'/*');
        foreach($aTplCacheFiles as $sFile) {
            // remove cache file if no folder
            if(!is_dir($sFile)) {
                @unlink($sFile);
            }
        }
    }

    /**
     * Clear persistent shop cache
     */
    protected function _resetPersistentCache() {
        $oUtils = Registry::getUtils();
        $sCacheDir = $oUtils->getCacheFilePath(null, true);
        $aDir = glob($sCacheDir.'*');
        if(is_array($aDir)) {
            $aDir = preg_grep("/c_fieldnames_|c_tbdsc_|_allfields_/", $aDir);
            foreach($aDir as $iKey => $sData) {
                if(!is_dir($sData)) {
                    @unlink($sData);
                }
            }
        }
    }

    /**
     * Prepare array with all cache files
     * @return array
     */
    protected function _getAllCacheFiles() {
        $oConfig = $this->getConfig();
        if($this->_oClearCache === null) {
            $this->_oClearCache = new \stdClass();
        }

        // get shop cache dir
        $sCacheDir = $oConfig->getConfigParam('sCompileDir');

        // get a list of all cache files
        $aCache = $aDir = glob($sCacheDir.'/*');
        $iFileCnt = 0;
        foreach($aDir as $iKey => $sData) {
            if(is_dir($sData)) {
                unset($aCache[$iKey]);
                $aSubDir = glob($sData.'/*');
                $aCache = array_merge($aCache, $aSubDir);

                if(str_replace('//', '/', $sData.'/') == str_replace('//', '/', Registry::get(UtilsView::class)->getSmartyDir())) {
                    $this->_oClearCache->iSmartyCacheFileCnt = count($aSubDir);
                    // get file size of smarty cache files
                    $sDuRes = exec('du -S --max-depth=1 ' . $sData.'/');
                    $iCacheBytes = substr($sDuRes, 0, strpos($sDuRes, $sData));
                    $this->_oClearCache->iSmartyCacheFileSize = $this->_formatHumanFileSize($iCacheBytes);
                }
            } else {
                $iFileCnt++;
            }
        }

        // get file count of shop cache files
        $this->_oClearCache->iShopCacheFileCnt = $iFileCnt;

        // get file size of shop cache files
        $sDuRes = exec('du -S --max-depth=1 '.$sCacheDir.'/');
        $iCacheBytes = substr( $sDuRes, 0, strpos($sDuRes, $sCacheDir));
        $this->_oClearCache->iShopCacheFileSize = $this->_formatHumanFileSize($iCacheBytes);

        return $aCache;
    }

    /**
     * Copy .htaccess file from config/.htaccess.tmp to cache folder
     */
    public function createHtaccessFile() {
        $oModule = oxNew(Module::class);
        $oConfig = $this->getConfig();
        // get modules path
        $sModulesDir = $oConfig->getModulesDir();
        // get cache path
        $sCacheDir = $oConfig->getConfigParam('sCompileDir');
        // check if the default .htaccess file is in config folder
        if(file_exists($sModulesDir.$oModule->getModulePath('suaboclearcache').'/Config/.htaccess.tmp')) {
            // copy .htaccess to cache folder
            copy($sModulesDir . $oModule->getModulePath('suaboclearcache') . '/Config/.htaccess.tmp', $sCacheDir . '/.htaccess');
        }
    }

    /**
     * Clear cache - ajax call
     */
    public function ajaxClearCache() {
        $this->clearCache();
        $this->_sThisTemplate = "suaboclearcache_popup.tpl";
    }
}