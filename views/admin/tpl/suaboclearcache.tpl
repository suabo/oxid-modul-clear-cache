[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<style>
    h1, h3 {
        padding-bottom: 0;
        margin-bottom: 0;
    }
    table {
        width: 100%;
    }

    .list span {
        display: inline-block;
        margin-top: 20px;
        padding: 4px 10px;
        border: solid #7A7A7A;
        border-radius: 4px 4px 0 0;
        border-width: 1px 1px 0 1px;
        background: #fff;
        margin-bottom: -1px;
        font-size:14px;
        font-family: Verdana, Arial, serif;
    }
    table.info td:first-child {
        text-align: right;
    }

    table.info td:last-child {
        font-weight: bold;
        text-align: left;
    }

    .btn {
        padding:4px 20px;
        border:1px solid darkgreen;
        border-radius:4px;
        cursor:pointer;
        color: darkgreen;
        background: #fff;
    }
    .btn:hover {
        box-shadow: 3px 3px 3px #ccc;
    }

    .btn.btn-danger {
        color:red;
        border-color:red;
    }

    .alert.alert-success {
        padding: 10px;
        border:1px solid green;
        border-radius: 4px;
        background: darkgreen;
        color:#fff;
    }

    .text-muted {
        color: #999;
    }

    pre {
        width: 90%;
        min-height:100px;
        max-height:300px;
        overflow-y:scroll;
        white-space: pre-line;
        background:#eee;
        padding:4px;
    }

    .settings {
        max-width:280px;
    }
</style>

[{if $blCacheCleared}]
    <style>
        .info .dynamic {
            color: darkgreen;
        }
    </style>
[{/if}]

<h1>[{oxmultilang ident="SUABOCLEARCACHE_TITLE"}]</h1>

<form name="clearcache" method="post" action="[{$oViewConf->getSelfLink()}]">
    <div>
        <input type="hidden" name="cl" value="suaboclearcache">
        <input type="hidden" name="fnc" value="">
    </div>
    <table>
        <colgroup>
            <col width="50%" />
            <col width="50%" />
        </colgroup>
        <tr>
            <td valign="top">
                <h2>[{oxmultilang ident="SUABOCLEARCACHE_SETTINGS"}]:</h2>
                <table class="settings">
                    <colgroup>
                        <col width="30px" />
                        <col width="" />
                    </colgroup>
                    <tr>
                        <td>
                            <input id="clearcacheall" type="radio" name="clearcache[mode]" value="0"
                                   onclick="clearCacheTotal();"[{if $aSettings.mode == 0}] CHECKED[{/if}]>
                        </td>
                        <td>
                            <label for="clearcacheall">[{oxmultilang ident="SUABOCLEARCACHE_SETTINGS_CLEAR_ALL"}]</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height:20px;">
                            <hr />
                            <div style="margin:-18px auto 0 auto;width:35px;text-align: center;background: #fff;">
                                [{oxmultilang ident="SUABOCLEARCACHE_OR"}]
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <input id="clearcacheparted" type="radio" name="clearcache[mode]" value="1"
                                   onclick="clearCacheParted(null, null);"[{if $aSettings.mode == 1}] CHECKED[{/if}]>
                        </td>
                        <td>
                            <label for="clearcacheparted">[{oxmultilang ident="SUABOCLEARCACHE_SETTINGS_PART_CLEAR"}]</label>
                            <div style="padding:15px;">
                                <table>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="clearShopCache" name="clearcache[shop]" value="1" onclick="clearCacheParted('shop', this);"[{if $aSettings.shop}] CHECKED[{/if}]>
                                        </td>
                                        <td><label for="clearShopCache">[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_SHOP"}]</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="clearPersParamCache" name="clearcache[persshop]" value="1" onclick="clearCacheParted('persshop', this);"[{if $aSettings.persshop}] CHECKED[{/if}]>
                                        </td>
                                        <td><label for="clearPersParamCache">[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_PERSSHOP"}]</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="clearTplCache" name="clearcache[tpl]" value="1" onclick="clearCacheParted('tpl', this);"[{if $aSettings.tpl}] CHECKED[{/if}]>
                                        </td>
                                        <td><label for="clearTplCache">[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_TPL"}]</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="clearLangCache" name="clearcache[lang]" value="1" onclick="clearCacheParted('lang', this);"[{if $aSettings.lang}] CHECKED[{/if}]>
                                        </td>
                                        <td><label for="clearLangCache">[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_LANG"}]</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="clearMenuCache" name="clearcache[menu]" value="1" onclick="clearCacheParted('menu', this);"[{if $aSettings.menu}] CHECKED[{/if}]>
                                        </td>
                                        <td><label for="clearMenuCache">[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_MENU"}]</label></td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <p class="text-muted">
                    [{oxmultilang ident="SUABOCLEARCACHE_SAVE_NOTICE"}]
                </p>

                <img id="suaboclearcache-preloader" src="[{$oViewConf->getModuleUrl('suaboclearcache', 'out/src/img/preloader.gif')}]" alt="save" style="display:none;float:left;margin:7px 10px 0 10px;">

                [{if !$oClearCache->isHtaccess}]
                    <button type="submit" class="btn btn-danger" onclick="document.clearcache.fnc.value = 'createHtaccessFile';">[{oxmultilang ident="SUABOCLEARCACHE_CREATE_HTACCESS"}]</button>
                [{/if}]

                <button type="submit" class="btn" onclick="document.clearcache.fnc.value = 'clearCache';">
                    [{oxmultilang ident="SUABOCLEARCACHE_CLEAR_CACHE_BUTTON"}]
                </button>
            </td>
            <td valign="top">
                <h2>[{oxmultilang ident="SUABOCLEARCACHE_INFORMATION"}]:</h2>
                <table class="info">
                    <tr>
                        <td colspan="2"><h3>[{oxmultilang ident="SUABOCLEARCACHE_SHOP_CACHE"}]:</h3></td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_SHOP_CACHE"}]:</td>
                        <td>[{$oClearCache->sCachePath}]</td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_COUNT"}]:</td>
                        <td class="dynamic">[{$oClearCache->iShopCacheFileCnt}]</td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                        <td class="dynamic">[{$oClearCache->iShopCacheFileSize}]</td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_IS_FOLDER_PROTECTED"}]:</td>
                        <td>[{if $oClearCache->isHtaccess}]<span style="color:darkgreen;">[{oxmultilang ident="SUABOCLEARCACHE_YES"}]</span>[{else}]<span style="color:red;">[{oxmultilang ident="SUABOCLEARCACHE_NO"}]</span>[{/if}]</td>
                    </tr>
                    <tr>
                        <td colspan="2"><hr><h3>[{oxmultilang ident="SUABOCLEARCACHE_SMARTY_CACHE"}]:</h3></td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_SMARTY_CACHE"}]:</td>
                        <td>[{$oClearCache->sSmartyCachePath}]</td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_COUNT"}]:</td>
                        <td class="dynamic">[{$oClearCache->iSmartyCacheFileCnt}]</td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                        <td class="dynamic">[{$oClearCache->iSmartyCacheFileSize}]</td>
                    </tr>
                    <tr>
                        <td colspan="2"><hr><h3>[{oxmultilang ident="SUABOCLEARCACHE_TOTAL"}]:</h3></td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_COUNT"}]:</td>
                        <td class="dynamic">[{$oClearCache->iFileCount}]</td>
                    </tr>
                    <tr>
                        <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                        <td class="dynamic">[{$oClearCache->iFileSize}]</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    [{if $blCacheCleared}]
        <br />
        <div class="alert alert-success">
            <span style="font-size:22px;color:lightgreen;font-weight:bold;padding-right:10px;">&#10003;</span>
            <span style="font-size:14px;font-weight:bold;">[{ oxmultilang ident="SUABOCLEARCACHE_CLEARCACHE_TEXT" }]</span>

            <div style="padding:0 32px;">
                [{if $oClearCache->iMode == 0}]
                    <p>
                        [{oxmultilang ident="SUABOCLEARCACHE_ALL_CLEAR"}]<br />
                        [{$oClearCache->iDeletedCacheFileCnt}] [{oxmultilang ident="SUABOCLEARCACHE_CACHE_FILES_DEL"}]
                    </p>
                [{else}]
                    <p>[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEARED"}]:</p>
                    <ul style="width:150px;list-style: circle;margin:0 10px 0;">
                        [{foreach from=$oClearCache->aSettings key=sSetting item=sVal}]
                            <li style="background: transparent;list-style: disc;">[{$sSetting}]</li>
                        [{/foreach}]
                    </ul>
                [{/if}]
            </div>
        </div>
        <br/><br/>
    [{/if}]

    <h2>[{oxmultilang ident="SUABOCLEARCACHE_DEBUG"}]:</h2>
    <table>
        <colgroup>
            <col width="50%" />
            <col width="50%" />
        </colgroup>
        <tr>
            <td valign="top">
                <table class="info">
                    <tr>
                        <td style="text-align: left;">[{oxmultilang ident="SUABOCLEARCACHE_SHOP_ERROR_LOG"}]:</td>
                        <td>[{$oDebug->sShopLogPath}]</td>
                    </tr>
                    <tr>
                        <td style="text-align: left;">[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                        <td>[{$oDebug->sShopLogFileSize}]</td>
                    </tr>
                    [{if $oDebug->sExceptionLogTail}]
                        <tr>
                            <td colspan="2">
                                <p>[{oxmultilang ident="SUABOCLEARCACHE_LAST_BYTES"}]:</p>
                                <pre>[{$oDebug->sExceptionLogTail|replace:'\n':"\n"}]</pre>
                            </td>
                        </tr>
                    [{/if}]
                </table>
            </td>
            <td valign="top">
                <table class="info">
                    [{if $oDebug->sPHPErrorLog && $oDebug->sPHPErrorLogSize}]
                    <tr>
                        <td style="text-align: left;">[{oxmultilang ident="SUABOCLEARCACHE_PHP_ERROR_LOG"}]:</td>
                        <td>[{$oDebug->sPHPErrorLogPath}]</td>
                    </tr>
                    <tr>
                        <td style="text-align: left;">[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                        <td>
                            [{if $oDebug->sPHPErrorLog}]
                                [{$oDebug->sPHPErrorLogSize}]
                            [{elseif $oDebug->sPHPErrorLogSize}]
                                <span style="color: red;">[{oxmultilang ident=$oDebug->sPHPErrorLogSize}]</span>
                            [{/if}]
                        </td>
                    </tr>
                    [{/if}]
                    <tr>
                        <td colspan="2">
                            [{if !$oDebug->sPHPErrorLog}]
                                <p class="text-muted">
                                    [{oxmultilang ident="SUABOCLEARCACHE_NO_PHP_LOG"}]
                                </p>
                            [{elseif $oDebug->sPHPErrorLogTail}]
                                <p>[{oxmultilang ident="SUABOCLEARCACHE_LAST_BYTES"}]:</p>
                                <pre>[{$oDebug->sPHPErrorLogTail}]</pre>
                            [{/if}]
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript">
    parent.sShopTitle = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
    parent.parent.sMenuItem = '[{oxmultilang ident="SUABOCLEARCACHE_TITLE"}]';
    parent.parent.sMenuSubItem = "";
    parent.parent.sWorkArea = "[{$_act}]";
    parent.setTitle();

    var clearCacheParted = function(part, elem) {
        document.getElementById('clearcacheall').checked = false;
        document.getElementById('clearcacheparted').checked = true;
        if(part != null && elem != null) {
            ajaxSave('1', part, elem.checked.toString());
        } else {
            ajaxSave('1', null, null);
        }
    };

    var clearCacheTotal = function() {
        ajaxSave('0', null, null);
    };

    var ajaxSave = function(mode, part, val) {
        var ple = document.getElementById('suaboclearcache-preloader'),
            xmlhttp = null;
        ple.style.display = 'block';
        if (window.XMLHttpRequest) {
            // AJAX nutzen mit IE7+, Chrome, Firefox, Safari, Opera
            xmlhttp = new XMLHttpRequest();
        } else {
            // AJAX mit IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                fade(ple);
                //console.log(xmlhttp.responseText);
            }
        };

        var url = "[{$oViewConf->getSelfLink()|replace:'&amp;':'&'|cat:'cl=suaboclearcache&fnc=saveSetting&mode='}]" + mode;
        if(part != undefined && part.length > 0) {
            url += "&name=" + part + "&value=" + val;
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    };

    var fade = function(element) {
        var op = 1;  // initial opacity
        var ccperiod = setInterval(function () {
            if (op <= 0.1) {
                op = 0.0;
                clearInterval(ccperiod);
                element.style.display = 'none';
            }
            element.style.opacity = op;
            element.style.filter = 'alpha(opacity=' + op * 100 + ")";
            op -= 0.1;
        }, 50);
    }
</script>

[{include file="bottomitem.tpl"}]