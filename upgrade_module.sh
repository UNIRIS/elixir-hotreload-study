#!/bin/sh
CODE=$(sqlite3 test.db "select code from contract where id = 1")
sudo /opt/hotreload/bin/hotreload rpc "$CODE"