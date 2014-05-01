      [{$smarty.block.parent}]
      
      <li class="sep">
          <a id="mgclearcache" class="rc" style="cursor:pointer;"><b>[{ oxmultilang ident="SUABOCLEARCACHE_BUTTON" }]</b></a>
      </li>
      
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>
      <script>
        $(function() {
          $('#mgclearcache').click(function() {
            $.ajax({
              url: "[{$oViewConf->getSelfLink()|replace:"&amp;":"&"|cat:"&cl=mgclearcache&fnc=cleartmp"}]",
              cache: false
            }).done(function( html ) {
              var body = $('body', parent.basefrm.document).append(html);
              if($(body).find('frame[name="list"]')) body = $('body', parent.basefrm.list.document).append(html);              
              $(body).find('.clearcachepopup').delay(1000).fadeOut(1000);
            });          
          });
        });       
      </script>