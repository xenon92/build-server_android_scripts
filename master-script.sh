# Android Compilation Script
#
# This script automates the process of compiling android
# operating system on build servers
#
# Copyright (C) 2014 Shubhang Rathore


# Use crontab to run master-script.sh
#
#
# Example crontab job:
#
# 30 18 * * * ~/build-scripts/master-script.sh



# Start tmux detached from main terminal
# If the session already exists, this command will
# be ignored
tmux new-session -d -s build-aogp

# Compiling Galaxy Grand i9082
tmux send-keys './device-scripts/build-i9082.sh' enter