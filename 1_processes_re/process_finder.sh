#!/bin/bash
ps aux | grep '$@' | awk '{print $2" "$1" "$3}'