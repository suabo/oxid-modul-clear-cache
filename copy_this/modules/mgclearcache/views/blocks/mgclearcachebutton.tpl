      [{$smarty.block.parent}]
      
      <li class="sep">
          <a id="mgclearcache" class="rc"><b>Tempräre Dateien löschen</b></a>
      </li>
      
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>
      <script>
        $(function() {
          $('#mgclearcache').click(function() {
            $.ajax({
              url: "[{$oViewConf->getSelfLink()|replace:"&amp;":"&"|cat:"&cl=mgclearcache&fnc=cleartmp"}]",
              cache: false
            }).done(function( html ) {
              $('body', parent.basefrm.document).append(html);              
              if($('.messagebox .details', parent.basefrm.document).length < 1)
                $('.messagebox', parent.basefrm.document).delay(3000).fadeOut(500);
              else
                $('.messagebox #closemessagebox', parent.basefrm.document).click(function() { $('.messagebox', parent.basefrm.document).fadeOut(500); });
            });          
          });
        });       
      </script>