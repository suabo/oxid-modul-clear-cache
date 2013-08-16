<?php
class mgclearcache extends oxAdminDetails {
    
    protected $_sThisTemplate = "mgclearcachepopup.tpl";
    protected $_sClearCacheLog;    
    
    public function render() {
      return parent::render();
    }
    
    public function cleartmp() {
        $this->_sClearLog = "";
        $aDir = glob('../tmp/*');
        $aDir = array_merge( $aDir, glob('../tmp/smarty/*') );
        foreach($aDir as $f) {
          if(!@unlink($f) && $f != "../tmp" && $f != "../tmp/smarty") {
            $this->_sClearCacheLog .= "Konnte Cachedatei \"".$f."\" nicht entfernen.<br>";
          }
        }
        $this->_aViewData["clearcachelog"] = $this->_sClearCacheLog;
    }
}
?>