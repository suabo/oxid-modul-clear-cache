[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<style>
    table {
        width: 100%;
    }

    .list span {
        display: inline-block;
        margin-top: 20px;
        padding: 4px 10px;
        border: 1px solid #7A7A7A;
        border-radius: 4px 4px 0 0;
        border-width: 1px 1px 0 1px;
        background: #fff;
        margin-bottom: -1px;
        font-size:14px;
        font-family: Verdana, Arial;
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
        border:1px solid #7A7A7A;
        border-radius:4px;
        cursor:pointer;
        color: darkgreen;
        border-color: darkgreen;
        background: #fff;
    }
    .btn:hover {
        box-shadow: 3px 3px 3px #ccc;
    }

    .btn.btn-danger {
        color:red;
        border-color:red;
    }

    .details {
        margin:10px 0;
        padding:4px;
        border:1px solid #333;
        max-height:100px;
        max-width:600px;
        overflow-y: scroll;
        white-space: nowrap;
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
        width: 500px;
        min-height:100px;
        max-height:100px;
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

<div class="list">
  <span>[{oxmultilang ident="SUABOCLEARCACHE_TITLE"}]</span>
</div>

<div class="box center">

    <form name="clearcache" method="post" action="[{$oViewConf->getSelfLink()}]">
        <div>
            <input type="hidden" name="cl" value="mgclearcache">
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
                                       onclick="JavaScript:clearCacheTotal();"[{if $aSettings.mode == 0}] CHECKED[{/if}]>
                            </td>
                            <td>[{oxmultilang ident="SUABOCLEARCACHE_SETTINGS_CLEAR_ALL"}]</td>
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
                                       onclick="JavaScript:clearCacheParted(null, null);"[{if $aSettings.mode == 1}] CHECKED[{/if}]>
                            </td>
                            <td>
                                [{oxmultilang ident="SUABOCLEARCACHE_SETTINGS_PART_CLEAR"}]
                                <div style="padding:15px;">
                                    <table>
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="clearcache[shop]" value="1" onclick="JavaScript:clearCacheParted('shop', this);"[{if $aSettings.shop}] CHECKED[{/if}]>
                                            </td>
                                            <td>[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_SHOP"}]</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="clearcache[persshop]" value="1" onclick="JavaScript:clearCacheParted('persshop', this);"[{if $aSettings.persshop}] CHECKED[{/if}]>
                                            </td>
                                            <td>[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_PERSSHOP"}]</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="clearcache[tpl]" value="1" onclick="JavaScript:clearCacheParted('tpl', this);"[{if $aSettings.tpl}] CHECKED[{/if}]>
                                            </td>
                                            <td>[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_TPL"}]</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="clearcache[lang]" value="1" onclick="JavaScript:clearCacheParted('lang', this);"[{if $aSettings.lang}] CHECKED[{/if}]>
                                            </td>
                                            <td>[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_LANG"}]</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="clearcache[menu]" value="1" onclick="JavaScript:clearCacheParted('menu', this);"[{if $aSettings.menu}] CHECKED[{/if}]>
                                            </td>
                                            <td>[{oxmultilang ident="SUABOCLEARCACHE_PART_CLEAR_MENU"}]</td>
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
                        <button type="submit" class="btn btn-danger" onclick="JavaScript:document.clearcache.fnc.value = 'createHtaccessFile';">[{oxmultilang ident="SUABOCLEARCACHE_CREATE_HTACCESS"}]</button>
                    [{/if}]

                    <button type="submit" class="btn" onclick="JavaScript:document.clearcache.fnc.value = 'clearCache';">
                        [{oxmultilang ident="SUABOCLEARCACHE_CLEAR_CACHE_BUTTON"}]
                    </button>
                </td>
                <td valign="top">
                    <h2>[{oxmultilang ident="SUABOCLEARCACHE_INFORMATION"}]:</h2>
                    <table class="info">
                        <tr>
                            <td colspan="2"><legend>[{oxmultilang ident="SUABOCLEARCACHE_SHOP_CACHE"}]:</legend></td>
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
                            <td colspan="2"><hr><legend>[{oxmultilang ident="SUABOCLEARCACHE_SMARTY_CACHE"}]:</legend></td>
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
                            <td colspan="2"><hr><legend>[{oxmultilang ident="SUABOCLEARCACHE_TOTAL"}]:</legend></td>
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
                            <td>[{oxmultilang ident="SUABOCLEARCACHE_SHOP_ERROR_LOG"}]:</td>
                            <td>[{$oDebug->sShopLogPath}]</td>
                        </tr>
                        <tr>
                            <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                            <td>[{$oDebug->sShopLogFileSize}]</td>
                        </tr>
                        [{if $oDebug->sExceptionLogTail}]
                            <tr>
                                <td colspan="2">
                                    <p>[{oxmultilang ident="SUABOCLEARCACHE_LAST_BYTES"}]:</p>
                                    <pre>[{$oDebug->sExceptionLogTail}]</pre>
                                </td>
                            </tr>
                        [{/if}]
                    </table>
                </td>
                <td valign="top">
                    <table class="info">
                        <tr>
                            <td>[{oxmultilang ident="SUABOCLEARCACHE_PHP_ERROR_LOG"}]:</td>
                            <td[{if !$oDebug->sPHPErrorLog}] style="color: red;"[{/if}]>[{$oDebug->sPHPErrorLogPath}]</td>
                        </tr>
                        <tr>
                            <td>[{oxmultilang ident="SUABOCLEARCACHE_FILE_SIZE"}]:</td>
                            <td>
                                [{if $oDebug->sPHPErrorLog}]
                                    [{$oDebug->sPHPErrorLogSize}]
                                [{else}]
                                    <span style="color: red;">[{oxmultilang ident=$oDebug->sPHPErrorLogSize}]</span>
                                [{/if}]
                            </td>
                        </tr>
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
</div>

<script type="text/javascript">
    parent.sShopTitle = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
    parent.parent.sMenuItem = "[{ oxmultilang ident="SUABOCLEARCACHE_TITLE" }]";
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
        var ple = document.getElementById('suaboclearcache-preloader');
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

        var url = "[{$oViewConf->getSelfLink()|replace:'&amp;':'&'|cat:'cl=mgclearcache&fnc=saveSetting&mode='}]" + mode;
        if(part != undefined && part.length > 0) {
            url += "&name=" + part + "&value=" + val;
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    };

    var fade = function(element) {
        var op = 1;  // initial opacity
        ccperiod = setInterval(function () {
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