#!/bin/sh

FILE=$(sqlite3 test.db "select file from contract where id = 1")
CODE=$(sqlite3 test.db "select code from contract where id = 1")
VERSION=$(sqlite3 test.db "select version from contract where id = 1")
echo $CODE > "lib/$FILE"

mix upgrade $VERSION