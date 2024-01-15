#!/bin/bash
# Startup script for base Minecraft Server

if [[ $(stat -c "%u" /data) != "$UID" ]]
then
    chown -R $UID:$GID /data
fi
if [[ $INSTALL == "FALSE" ]]
then
    if [[ -z "$JVM_ARGS_FILE" ]]
    then
        echo "No JVM Arguments File provided! Cannot start the server!"
        exit 1
    elif [[ -z $VERSION ]]
    then
        echo "Version not provided! Cannot start the server!"
        exit 1
    elif [[ -z $TYPE ]]
    then
        echo "Server type not provided! Cannot start the server!"
        exit 1
    elif [[ $TYPE == "FORGE" ]]
    then
        if [[ -z $FORGE_VERSION ]]
        then
            echo "Forge version not provided! Cannot start the server!"
            exit 1
        fi
    fi
fi
if ! [ -f /data/eula.txt ]
then
    if [[ "$EULA" == "TRUE" ]]
    then
        echo "# Generated via Docker
        # $(date)
        eula=true
        "> /data/eula.txt
        chown $UID:$GID eula.txt
    fi
fi

if ! [ -f /data/server-icon.png ]
then
    if ! [[ -z $ICON_URL ]]
    then
        wget $ICON_URL -O /data/server-icon.png
        chown $UID:$GID server-icon.png
    fi
fi
if ! [ -f /data/server.properties ]
then
    echo "enable-query=true" > /data/server.properties
    chown $UID:$GID server.properties
fi
if ! [ -f /data/ops.json ]
then
    if ! [[ -z $OPS ]]
    then
        curl -H "Content-Type: application/json" -d '["'$OPS'"]' -X POST https://api.minecraftservices.com/minecraft/profile/lookup/bulk/byname > /tmp/ops.json
        UUID=$(cat /tmp/ops.json | jq .[0].id)
        NAME=$(cat /tmp/ops.json | jq .[0].name)
        UUID="${UUID:0:9}-${UUID:9:4}-${UUID:13:4}-${UUID:17:4}-${UUID:21:13}"
        FILE='[ { "uuid":'$UUID', "name":'$NAME', "level":4, "bypassesPlayerLimit":false } ]'
        echo $(echo $FILE | jq . ) > /data/ops.json
        chown $UID:$GID ops.json
    fi
fi
JAVA_P=$JAVA_HOME/bin/java
if [[ "$INSTALL" == "TRUE" ]]
then
    if [[ -z $INSTALLER ]]
    then
        echo "Need to provide the installer jar!"
        exit 1
    else
        echo "Installing server, assuming Forge"
        exec gosu ${UID}:${GID}  "${JAVA_P}" -jar ${INSTALLER} --installServer
    fi
else
    if [[ -f /data/run.sh ]]
    then
        echo "Found run script."
        if [[ $TYPE == "FORGE" ]]
        then
            echo "Server is Forge, starting server according."
            exec gosu ${UID}:${GID} "${JAVA_P}" @$JVM_ARGS_FILE @libraries/net/minecraftforge/forge/$VERSION-$FORGE_VERSION/unix_args.txt
        else
            echo "Server is not Forge, ignoring run script"
            exec gosu ${UID}:${GID} "${JAVA_P}" @$JVM_ARGS_FILE -jar $SERVER_JAR nogui
        fi
    else
        exec gosu ${UID}:${GID} "${JAVA_P}" @$JVM_ARGS_FILE -jar $SERVER_JAR nogui
    fi
fi

