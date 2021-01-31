#!/bin/sh

# Utility to tunnel auth socket to the container through `docker exec`
# Socat needs to be installed inside of the container.
#
# On OSX run (with path to your private key)
#   ssh-add -K ~/.ssh/id_ed25519
#
# After that
#   ./forward-auth-socket.sh container-name
#
# Inside container
#   export SSH_AUTH_SOCK=/tmp/auth.sock

CONTAINER=$1

docker exec -i $CONTAINER rm -f /tmp/auth.sock
socat "EXEC:docker exec -i $CONTAINER 'socat UNIX-LISTEN:/tmp/auth.sock,fork STDIO'" UNIX:$SSH_AUTH_SOCK
