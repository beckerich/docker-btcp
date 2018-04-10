#!/bin/bash
: ${CONTAINER_NAME:="dockerbtcp_btcpd_1"}
docker exec ${CONTAINER_NAME} cli "$@"
