<?php

namespace Suabo\ClearCache\Controller\Admin;

use OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\EshopCommunity\Internal\Container\ContainerFactory;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Facade\ModuleSettingServiceInterface;
use Psr\Container\ContainerExceptionInterface;
use Psr\Container\NotFoundExceptionInterface;
use stdClass;

/**
 * Class ClearCache
 */
class ClearCache extends AdminDetailsController {

    /**
     * Template
     * @var string
     */
    protected $_sThisTemplate = "@suaboclearcache/clear_cache";

    /**
     * Clear cache object
     * @var null|stdClass
     */
    protected ?stdClass $clearCache = null;

    /**
     * Debug object
     * @var null|stdClass
     */
    protected ?stdClass $debug = null;

    /**
     * Render Template
     * @return string
     * @throws ContainerExceptionInterface
     * @throws NotFoundExceptionInterface
     */
    public function render() {
        $this->_aViewData['aSettings'] = $this->loadSettings();
        $this->_aViewData['oClearCache'] = $this->getCacheInfo();
        $this->_aViewData['oDebug'] = $this->getDebugInfo();

        return parent::render();
    }

    /**
     * Save Settings
     */
    public function saveSetting(): void
    {

        $moduleSettingService = ContainerFactory::getInstance()
            ->getContainer()
            ->get(ModuleSettingServiceInterface::class);

        $aMapping = array(
            'shop'      => 'blSuaboClearCacheShop',
            'persshop'  => 'blSuaboClearCachePersShop',
            'tpl'       => 'blSuaboClearCacheTpl',
            'lang'      => 'blSuaboClearCacheLang',
            'menu'      => 'blSuaboClearCacheMenu',
        );

        $oRequest = Registry::getRequest();
        $sName = $oRequest->getRequestParameter('name');
        $sValue = $oRequest->getRequestParameter('value');
        $iMode = $oRequest->getRequestParameter('mode');

        if($sName !== null && $sValue !== null) {
            $moduleSettingService->saveBoolean($aMapping[$sName], $sValue, 'suaboclearcache');
        }
        $moduleSettingService->saveString('blSuaboClearCacheMode', $iMode, 'suaboclearcache');

        // debug msg
        Registry::getUtils()->showMessageAndExit($aMapping[$sName].' saved with value '.$sValue);
    }

    /**
     * Load settings
     * @return array
     * @throws ContainerExceptionInterface
     * @throws NotFoundExceptionInterface
     */
    protected function loadSettings(): array
    {
        $moduleSettingService = ContainerFactory::getInstance()
            ->getContainer()
            ->get(ModuleSettingServiceInterface::class);
        return [
            'mode' => $moduleSettingService->getString('blSuaboClearCacheMode', 'suaboclearcache')->toString(),
            'shop' => $moduleSettingService->getBoolean('blSuaboClearCacheShop', 'suaboclearcache'),
            'persshop' => $moduleSettingService->getBoolean('blSuaboClearCachePersShop', 'suaboclearcache'),
            'tpl' => $moduleSettingService->getBoolean('blSuaboClearCacheTpl', 'suaboclearcache'),
            'lang' => $moduleSettingService->getBoolean('blSuaboClearCacheLang', 'suaboclearcache'),
            'menu' => $moduleSettingService->getBoolean('blSuaboClearCacheMenu', 'suaboclearcache'),
        ];
    }

    /**
     * Get debug infos
     * @return null|stdClass
     * @throws ContainerExceptionInterface
     * @throws NotFoundExceptionInterface
     */
    protected function getDebugInfo(): ?stdClass
    {
        $moduleSettingService = ContainerFactory::getInstance()
            ->getContainer()
            ->get(ModuleSettingServiceInterface::class);
        $oConfig = Registry::getConfig();
        if($this->debug === null) {
            $this->debug = new stdClass();
        }

        // check php error log
        $sPHPErrorLogPath = $moduleSettingService->getString('blSuaboPHPErrorLogPath', 'suaboclearcache');
        if(file_exists($sPHPErrorLogPath)) {
            $this->debug->sPHPErrorLog = true;
            $this->debug->sPHPErrorLogPath = $sPHPErrorLogPath;
            $this->debug->sPHPErrorLogSize = $this->getHumanReadableFileSize($sPHPErrorLogPath);
        } else {
            //try to get the path from php settings
            $sPHPErrorLogPath = ini_get('error_log');
            if(!empty($sPHPErrorLogPath)) {
                $this->debug->sPHPErrorLogPath = $sPHPErrorLogPath;
                if(file_exists($sPHPErrorLogPath)) {
                    $this->debug->sPHPErrorLog = true;
                    $this->debug->sPHPErrorLogSize = $this->getHumanReadableFileSize($sPHPErrorLogPath);
                } else {
                    $this->debug->sPHPErrorLogSize = "SUABOCLEARCACHE_ERROR_PHP_FILE_SIZE";
                }
            }
        }

        // get tail of php error log
        if(file_exists($sPHPErrorLogPath)) {
            $fh = fopen($sPHPErrorLogPath, 'r');
            $offset = filesize($sPHPErrorLogPath) - 4096;
            fseek($fh, max($offset, 0));
            $this->debug->sPHPErrorLogTail = fread($fh, 4096);
            $lastErrorPos = strpos($this->debug->sPHPErrorLogTail, "\n");
            $this->debug->sPHPErrorLogTail = substr($this->debug->sPHPErrorLogTail, $lastErrorPos !== false ? $lastErrorPos : 0);
            fclose($fh);
        }

        // check exception log
        $sLogPath = $oConfig->getConfigParam('sShopDir')."log/oxideshop.log";
        if(file_exists($sLogPath)) {
            $this->debug->sShopLogPath = $sLogPath;
            $this->debug->sShopLogFileSize = $this->getHumanReadableFileSize($sLogPath);
            // get tail of exception log
            $fh = fopen($sLogPath, 'r');
            $offset = filesize($sLogPath) - 4096;
            fseek($fh, max($offset, 0));
            $this->debug->sExceptionLogTail = fread($fh, 4096);
            $lastErrorPos = strpos($this->debug->sExceptionLogTail, "\n");
            $this->debug->sExceptionLogTail = substr($this->debug->sExceptionLogTail, $lastErrorPos !== false ? $lastErrorPos : 0);
            fclose($fh);
        } else {
            $this->debug->sShopLogPath = "oxideshop.log wurde nicht gefunden!";
        }

        return $this->debug;
    }

    /**
     * Get human-readable file size
     * @param $path
     * @return string
     */
    protected function getHumanReadableFileSize($path): string
    {
        $iBytes = filesize($path);
        return $this->formatHumanFileSize($iBytes);
    }

    /**
     * Format file size into human-readable format
     * @param $iBytes
     * @return string
     */
    protected function formatHumanFileSize($iBytes): string
    {
        $sz = 'BKMGTP';
        $factor = floor((strlen($iBytes) - 1) / 3);
        return str_replace(array('B', 'K', 'M', 'G', 'T', 'P'), array('Byte', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb'), sprintf("%.2f", $iBytes / pow(1024, $factor)).' '.@$sz[intval($factor)]);
    }

    /**
     * get cache information
     * @return null|stdClass
     */
    protected function getCacheInfo(): ?stdClass
    {
        $oConfig = Registry::getConfig();
        // init response object
        if($this->clearCache === null) {
            $this->clearCache = new stdClass();
        }

        // get shop cache dir
        $sCacheDir = $oConfig->getConfigParam('sCompileDir');

        // get all cache files array
        $aCache = $this->getAllCacheFiles();
        // set total cache file count
        $this->clearCache->iFileCount = count($aCache);

        // check file size of cache
        $sDuRes = exec('du --summarize '.$sCacheDir.'/');
        $iCacheBytes = substr($sDuRes, 0, strpos($sDuRes, $sCacheDir));
        $this->clearCache->iFileSize = $this->formatHumanFileSize($iCacheBytes);

        // check for htaccess file
        $this->clearCache->isHtaccess = file_exists($sCacheDir.'/.htaccess');
        // get cache dir
        $this->clearCache->sCachePath = $oConfig->getConfigParam('sCompileDir');
        // get template cache dir
        /*
        $this->clearCache->templateCachePath = ContainerFactory::getInstance()
            ->getContainer()
            ->get(ShopTemplateCacheServiceInterface::class)->getCacheDirectory($oConfig->getShopId());
        */

        return $this->clearCache;
    }

    /**
     * Clear cache
     */
    public function clearCache(): void
    {
        if($this->clearCache === null) {
            $this->clearCache = new stdClass();
        }

        $oRequest = Registry::getRequest();
        $oUtils = Registry::getUtils();
        $aClearCache = $oRequest->getRequestParameter('clearcache');
        if(empty($aClearCache) || !is_array($aClearCache)) {
            // load saved vars to perform cache clear if we got no post-settings
            $aClearCache = $this->loadSettings();
        }
        $this->clearCache->aSettings = array();

        // check for clearing mode
        $this->clearCache->iMode = intval($aClearCache['mode']);
        if($this->clearCache->iMode == 0) {
            // clear all cache files
            $aCache = $this->getAllCacheFiles();
            foreach($aCache as $sFile) {
                // remove cache file if no folder
                if(!is_dir($sFile) && @unlink($sFile)) {
                    if(!is_array($this->clearCache->aDeletedCacheFiles)) {
                        $this->clearCache->aDeletedCacheFiles = array();
                    }
                    // append file to log array
                    $this->clearCache->aDeletedCacheFiles[] = $sFile;
                }
            }

            $this->clearCache->iDeletedCacheFileCnt = count($this->clearCache->aDeletedCacheFiles);

        } else {
            // clear shop cache
            if($aClearCache['shop']) {
                $this->clearCache->aSettings['Shop'] = true;
                $oUtils->oxResetFileCache();
            }
            // clear persistent shop cache
            if($aClearCache['persshop']) {
                $this->clearCache->aSettings['Persistent'] = true;
                $this->resetPersistentCache();
            }
            // clear tpl cache
            if($aClearCache['tpl']) {
                $this->clearCache->aSettings['Template'] = true;
                $this->resetTemplateCache();
            }
            // clear language cache
            if($aClearCache['lang']) {
                $this->clearCache->aSettings['Language'] = true;
                $oUtils->resetLanguageCache();
            }
            // clear menu cache
            if($aClearCache['menu']) {
                $this->clearCache->aSettings['Menu'] = true;
                $oUtils->resetMenuCache();
            }
        }

        $this->_aViewData["blCacheCleared"] = true;
    }

    /**
     * Clear template cache
     */
    protected function resetTemplateCache(): void
    {
        $shopId = Registry::getConfig()->getShopId();
        /*
        // get all template cache files
        $aTplCacheFiles = glob(Registry::get(UtilsView::class)->getSmartyDir().'/*');
        $aTplCacheFiles = [];
        foreach($aTplCacheFiles as $sFile) {
            // remove cache file if no folder
            if(!is_dir($sFile)) {
                @unlink($sFile);
            }
        }
        */
        // clear template cache
        //ContainerFactory::getInstance()->getContainer()->get(ShopTemplateCacheServiceInterface::class)->invalidateCache($shopId);
    }

    /**
     * Clear persistent shop cache
     */
    protected function resetPersistentCache(): void
    {
        $oUtils = Registry::getUtils();
        $sCacheDir = $oUtils->getCacheFilePath(null, true);
        $aDir = glob($sCacheDir.'*');
        if(is_array($aDir)) {
            $aDir = preg_grep("/c_fieldnames_|c_tbdsc_|_allfields_/", $aDir);
            foreach($aDir as $sData) {
                if(!is_dir($sData)) {
                    @unlink($sData);
                }
            }
        }
    }

    /**
     * Prepare an array with all cache files
     * @return array
     */
    protected function getAllCacheFiles(): array
    {
        $oConfig = Registry::getConfig();
        if($this->clearCache === null) {
            $this->clearCache = new stdClass();
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
                /*
                $cacheDirectory = ContainerFactory::getInstance()
                    ->getContainer()
                    ->get(ShopTemplateCacheServiceInterface::class)->getCacheDirectory($oConfig->getShopId());

                if(str_replace('//', '/', $sData.'/') == str_replace('//', '/', $cacheDirectory)) {
                    $this->clearCache->templateCacheFileCnt = count($aSubDir);
                    // get file size of smarty cache files
                    $sDuRes = exec('du -S --max-depth=1 ' . $sData.'/');
                    $iCacheBytes = substr($sDuRes, 0, strpos($sDuRes, $sData));
                    $this->clearCache->templateCacheFileSize = $this->formatHumanFileSize($iCacheBytes);
                }
                */
            } else {
                $iFileCnt++;
            }
        }

        // get file count of shop cache files
        $this->clearCache->iShopCacheFileCnt = $iFileCnt;

        // get file size of shop cache files
        $sDuRes = exec('du -S --max-depth=1 '.$sCacheDir.'/');
        $iCacheBytes = substr( $sDuRes, 0, strpos($sDuRes, $sCacheDir));
        $this->clearCache->iShopCacheFileSize = $this->formatHumanFileSize($iCacheBytes);

        return $aCache;
    }

    /**
     * Clear cache - ajax call
     */
    public function ajaxClearCache(): void
    {
        $this->clearCache();
        $this->_sThisTemplate = "@suaboclearcache/clear_cache_popup";
    }
}