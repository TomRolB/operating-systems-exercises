#!/bin/bash
ps aux | sort -k4 -r | head -n 11 > memory.txt