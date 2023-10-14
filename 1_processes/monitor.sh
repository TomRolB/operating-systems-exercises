#!/bin/bash
ps aux | sort -k4 | awk '{print $11}' > memory.txt

# Almost correct.
# Problem: doesn't sort by numerical value, but by string value.
# Besides, if the name of the process has spaces, only the first
# word of it will be considered as part of the eleventh column.
# Finally, it takes all of the processes, not only the top 10.
