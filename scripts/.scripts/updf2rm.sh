#!/bin/bash
name=$1
echo $1
echo $2
~/bin/pdf2rmnotebook/ "$1"
mv $PWD/Notebook.zip ~/remarkable/xochitl/
cd ~/remarkable/xochitl/
uuid=$(unzip Notebook.zip | grep .content | cut -d ' ' -f 4 | cut -d '.' -f1)
echo $uuid
echo '
{
    "deleted": false,
    "lastModified": "1638094674918",
    "lastOpened": "1638438026678",
    "lastOpenedPage": 0,
    "metadatamodified": false,
    "modified": false,
    "parent": "",
    "pinned": false,
    "synced": false,
    "type": "DocumentType",
    "version": 1,
    "visibleName": "'"$1"'"
}' > $uuid.metadata

