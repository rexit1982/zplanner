#!/bin/bash

echo "Updating zPlanner from github"
(cd /home/zerto/zplanner/ && git reset --hard HEAD && git pull http://www.github.com/rexit1982/zplanner/)
echo "Running Update Helper Script"
(/bin/bash /home/zerto/zplanner/updates.sh)

