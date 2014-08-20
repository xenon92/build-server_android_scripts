# Android Compilation Script
#
# This script automates the process of compiling android
# operating system on build servers
#
# Copyright (C) 2014 Shubhang Rathore
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



# Use crontab to run master-script.sh
#
#
# Example crontab job:
#
# 30 18 * * * ~/build-scripts/master-script.sh



# Start tmux detached from main terminal
# If the session already exists, this command will
# be ignored
tmux new-session -d -s build-rom

# Compiling
tmux send-keys '~/build-scripts/device-scripts/build-hammerhead.sh' enter
tmux send-keys '~/build-scripts/device-scripts/build-i9082.sh' enter