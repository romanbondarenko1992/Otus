#!/bin/bash

mysqldump --all-databases --triggers --routines --master-data --ignore-table=bet.events_on_demand --ignore-table=bet.v_same_event > /tmp/master.sql && scp /tmp/master.sql root@slave:/vagrant 
