#!/usr/bin/env bash
set -euo pipefail

log() { printf -- "** %s\n" "$*" >&2; }
error() { printf -- "** ERROR: %s\n" "$*" >&2; }
fatal() { error "$@"; exit 1; }

CURRENT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(git -C "${CURRENT_SCRIPT_DIR}" rev-parse --show-toplevel)"

OPENAPI_YAML="${REPO_ROOT}/openapi/openapi.yaml";
TYPES_OUTPUT="${REPO_ROOT}/Sources/SystemOpenAPIRuntimeKit/";
SERVER_OUTPUT="${REPO_ROOT}/Sources/SystemServerKit/";

swift-openapi-generator generate \
    --mode types \
    --output-directory "${TYPES_OUTPUT}" \
    --access-modifier public \
#    --additional-import "CoreOpenAPIRuntimeKit" \
    "${OPENAPI_YAML}"

swift-openapi-generator generate \
    --mode server \
    --output-directory "${SERVER_OUTPUT}" \
    --access-modifier public \
    --additional-import "SystemOpenAPIRuntimeKit" \
    "${OPENAPI_YAML}"

