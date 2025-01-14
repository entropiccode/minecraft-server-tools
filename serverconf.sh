# serverconf.sh
# configuration file for server.sh minecraft server
# management script

VERBOSE=0

#CONFIG
JRE_JAVA="java"
JVM_ARGS="-Xms7G -Xmx7G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
JAR="fabric-server-launch.jar"
JAR_ARGS="nogui"

# When setting the TARGET_VER, take your desired Minecraft version
# Add zeroes such that there is a tens and ones digit in the second and third sections
# 1.6.4 becomes 1.06.04
# Remove the periods
# 1.06.04 becomes 10604
#
# Common Versions:
# 1.18.2    ->  11802
# 1.16.5    ->  11605
# 1.12.2    ->  11202
# 1.7.10    ->  10710
# 1.6.4     ->  10604
# 1.4.7     ->  10407

TARGET_VER=11802
MC_VER="1.18.2"
FORGE_VER="40.1.20"

TMUX_WINDOW="minecraft"
TMUX_SOCKET="mc_tmux_socket"

WORLD_NAME="asdf"
if [ -f "server.properties" ]; then
    WORLD_NAME=$(grep level-name server.properties | cut -d= -f2)
    echo "Getting world name from server.properties: $WORLD_NAME"
fi

BACKUP_NAME="${WORLD_NAME}_backup"
LOGFILE="logs/latest.log"
PIDFILE="server-screen.pid"
# if not bup or borg, uses tar by default
BACKUP_BACKEND="tar"
#BACKUP_BACKEND="bup"
#BACKUP_BACKEND="borg"

#Constants
CUR_YEAR=`date +"%Y"`
NEW_FORGE=11700     # Fixed at 11700 (1.17.0) as this is when Forge implemented their new run script

# IMPORTANT: local paths must be absolute!
BACKUP_DIRS=( "$PWD/.bak/$CUR_YEAR" )

# borg repository could be pasword-protected
# to avoid having to manually type password, borg can run a command that should echo a password
#BACKUP_PASSCOMMAND="echo superstrongpassword"
#BACKUP_PASSCOMMAND="pass passwordname"

# 0 - don't check backups after creation
# 1 - check only local backups
# 2 - check local and remote backups (may take a while if world is large and connection is slow)
BACKUP_CHECK_MODE=1
