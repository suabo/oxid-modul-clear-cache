[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]
<div class="list">
  <span style="display:inline-block;margin-top:20px;padding:4px 10px;border:1px solid #7A7A7A;border-radius:4px 4px 0 0;border-width:1px 1px 0 1px;background:#fff;margin-bottom:-1px;">
    [{ oxmultilang ident="SUABOCLEARCACHE_CLEARCACHE_HEADLINE" }]    
  </span>
</div>
<div class="box center">  
  <span style="font-size:32px;color:lightgreen;font-weight:bold;padding-right:10px;">&#10003;</span><span style="font-size:16px;">
    [{ oxmultilang ident="SUABOCLEARCACHE_CLEARCACHE_TEXT" }]
  </span>
  [{if $clearcachelog}]
  <div class="details">
    [{$clearcachelog}]
  </div>  
  [{/if}]
  <br><br>
  <div id="clearcacheinfocontainer">
    <span id="clearcacheinfotrigger" style="padding:4px 20px;border:1px solid #7A7A7A;border-radius:4px;cursor:pointer;" onClick="Javascript:document.getElementById('clearcacheinfo').style.display = 'block';">
      [{ oxmultilang ident="SUABOCLEARCACHE_TIPP_HEADLINE" }]
    </span><br>
    <div id="clearcacheinfo" style="display:none;">
      <br>
      [{ oxmultilang ident="SUABOCLEARCACHE_TIPP_TEXT" }]:
      <br>
      <br>
      <code>    
        [<!-- -->{block name="header_buttons"}<!-- -->]<br>    
          ...<br>      
        [<!-- -->{/block}<!-- -->]<br>
      </code>  
      <br>
      <br>
      [{ oxmultilang ident="SUABOCLEARCACHE_TIPP_TEXT2" }]:<br>
      <br>
      <code>
        ...<br>
        <ul><br>
          [<!-- -->{block name="header_buttons"}<!-- -->]<br>
            <<!-- -->li class="act"<!-- -->><br>
                <<!-- -->a href="[<!-- -->{$oViewConf->getSelfLink()}<!-- -->]&cl=navigation&amp;item=home.tpl" id="homelink" target="basefrm" class="rc"><<!-- -->b>[<!-- -->{ oxmultilang ident="NAVIGATION_HOME" }<!-- -->]<<!-- -->/b><<!-- -->/a><br>
            <<!-- -->/li><br>
            <<!-- -->li class="sep"><br>
                <<!-- -->a href="[<!-- -->{$oConfig->getShopURL()}<!-- -->]" id="shopfrontlink" target="_blank" class="rc"><<!-- -->b>[<!-- -->{ oxmultilang ident="NAVIGATION_SHOPFRONT" }<!-- -->]<<!-- -->/b><<!-- -->/a><br>
            <<!-- -->/li><br>
            <<!-- -->li class="sep"><br>
                <<!-- -->a href="[<!-- -->{$oViewConf->getSelfLink()}<!-- -->]&cl=navigation&amp;fnc=logout" id="logoutlink" target="_parent" class="rc"><<!-- -->b>[<!-- -->{ oxmultilang ident="NAVIGATION_LOGOUT" }<!-- -->]<<!-- -->/b><<!-- -->/a><br>
            <<!-- -->/li><br>
          [<!-- -->{/block}<!-- -->]<br>
        <<!-- -->/ul><br>
        ...  
      </code>
      <br>
      [{ oxmultilang ident="SUABOCLEARCACHE_TIPP_TEXT3" }]
    </div>
  </div>
</div>