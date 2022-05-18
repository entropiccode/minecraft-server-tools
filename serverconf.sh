# serverconf.sh
# configuration file for server.sh minecraft server
# management script

VERBOSE=0

#CONFIG
JRE_JAVA="java"
JVM_ARGS="-Xms4096M -Xmx6144M"
JAR="fabric-server-launch.jar"
JAR_ARGS="-nogui"

# TMUX_WINDOW="minecraft"
# TMUX_SOCKET="mc_tmux_socket"

SCREEN_WINDOW="minecraft"

WORLD_NAME="world"
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
