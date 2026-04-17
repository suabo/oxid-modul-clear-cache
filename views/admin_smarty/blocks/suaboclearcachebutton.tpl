[{$smarty.block.parent}]
      
<li class="sep">
    <a id="mgclearcache" class="rc" style="cursor:pointer;float:left;">
        <b style="float:left;">[{ oxmultilang ident="SUABOCLEARCACHE_BUTTON" }]</b>
        <img id="suaboclearcache-preloader" src="[{$oViewConf->getModuleUrl('suaboclearcache', 'out/src/img/preloader.gif')}]" alt="loading" style="display:none;float:right;margin-right:10px;">
    </a>
    <a href="[{$oViewConf->getSelfLink()|cat:'cl=suaboclearcache'}]" target="basefrm" style="float:right;">
        <img src="[{$oViewConf->getModuleUrl('suaboclearcache', 'out/src/img/settings.svg')}]" alt="[{oxmultilang ident="SUABOCLEARCACHE_SETTINGS_ALT_TEXT"}]" width="15px" height="15px" style="margin-top:2px;">
    </a>

    <script>
        var cctimer = null;
        var ccperiod = null;
        var ccAnchor = document.getElementById('mgclearcache');
        ccAnchor.onclick = function() {
            // get target frame
            var ptf = null;
            if(parent.basefrm.list != undefined && parent.basefrm.list.document != undefined) {
                ptf = parent.basefrm.list.document;
            } else {
                ptf = parent.basefrm.document;
            }
            // remove old popup if it is still there
            var ope = ptf.getElementById('clearcachepopup');
            if(ope != undefined && ope.parentNode != undefined) {
                ope.parentNode.removeChild(ope);
                clearInterval(ccperiod);
                clearTimeout(cctimer);
            }
            // get preloader image element
            var pe = document.getElementById('suaboclearcache-preloader');
            pe.style.opacity = 1.0;
            pe.style.display = 'block';
            //ajax
            var url = "[{$oViewConf->getSelfLink()|replace:"&amp;":"&"|cat:"&cl=suaboclearcache&fnc=ajaxClearCache"}]";
            if (window.XMLHttpRequest) {
                // AJAX nutzen mit IE7+, Chrome, Firefox, Safari, Opera
                xmlhttp = new XMLHttpRequest();
            } else {
                // AJAX mit IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    fade(pe);
                    ptf.body.innerHTML += xmlhttp.responseText;

                    cctimer = window.setTimeout(function() {
                        fade(ptf.getElementById('clearcachepopup'), true);
                    }, 1000);
                }
            };

            xmlhttp.open("GET",url,true);
            xmlhttp.send();
            return false;
        };

        var fade = function(element, remove) {
            var op = 1;  // initial opacity
            ccperiod = setInterval(function () {
                if (op <= 0.1) {
                    op = 0.0;
                    clearInterval(ccperiod);
                    if(remove != undefined) {
                        element.parentNode.removeChild(element);
                    }  else {
                        element.style.display = 'none';
                    }
                }
                element.style.opacity = op;
                element.style.filter = 'alpha(opacity=' + op * 100 + ")";
                op -= 0.1;
            }, 50);
        }
    </script>
</li>