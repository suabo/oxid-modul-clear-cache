<?php
class admin_cleartmp extends admin_cleartmp_parent {
    
    public function cleartmp() {
        $aDir = glob('../tmp/*');
        foreach($aDir as $f) unlink($f);
    }
}
?>