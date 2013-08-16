<style>
.messagebox{position:absolute;top:100px;left:50%;margin-left:-225px;width:450px;padding:10px;border:3px solid #ccc;border-radius:5px;background:#fff;color:#666;}
.messagebox h1{font-size:18px;font-family:Verdana;color:#666;border-bottom:3px solid #ccc;padding:10px;margin:-10px -10px 0 -10px;background:lightgreen;}
.messagebox .details{height:50px;width:400px;overflow-y:auto;}
</style>
<div class="messagebox">
  <h1>Cache geleert</h1>
  <span style="font-size:32px;color:lightgreen;font-weight:bold;padding-right:10px;">&#10003;</span>Ihre Temporären Shopdateien wurden erfolgreich gelöscht.
  [{if $clearcachelog}]
  <div class="details">
    [{$clearcachelog}]
  </div>
  <a id="closemessagebox">Fenster schließen</a>
  [{/if}]
</div>