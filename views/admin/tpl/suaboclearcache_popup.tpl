<div id="clearcachepopup" class="clearcachepopup">
    <style scoped="scoped">
        .clearcachepopup {
            position: absolute;
            top: 100px;
            left: 50%;
            margin-left: -225px;
            width: 450px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #fff;
            color: #666;
            box-shadow: 3px 3px 3px 0 #666;
        }

        .clearcachepopup h1 {
            font-size: 18px;
            font-family: Verdana, sans-serif;
            color: #fff;
            border-bottom: 1px solid #ccc;
            padding: 10px;
            margin: -10px -10px 0 -10px;
            background: darkgreen;
        }

        .clearcachepopup .headline {
            font-size: 32px;
            color: lightgreen;
            font-weight: bold;
            padding-right: 10px;
        }
    </style>

    <h1><span class="headline">&#10003;</span> [{oxmultilang ident="SUABOCLEARCACHE_CLEARCACHE_HEADLINE"}]</h1>
    <div style="padding:15px;">
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