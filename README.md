Clear Shopcache
===============

1. copy_this in Shop Root Verzeichnis kopieren
2. Modul im Backend aktivieren
3. Tmp/Chache letztes mal von Hand leeren

## Clear faster, without loosing changes made: ##

To clear it faster and without lossing changes made in edit mask we added a 
templateblock in admin/tpl/header.tpl `header_buttons`:

    <ul>
    [{block name="header_buttons"}]
    ...
    <li>...</li>
    ..
    [{/block}]
    </ul>
