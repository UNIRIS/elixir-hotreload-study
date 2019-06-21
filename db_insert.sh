#!/bin/sh

sqlite3 test.db "create table if not exists contract(id int primary_key, file varchar(255), code text, version varchar(1000))"
sqlite3 test.db "insert into contract values (1, 'hotreload/message.ex', 'defmodule Hotreload.Message do
    def hello do
        \"Sam\"
    end
end', '1.0.6')"