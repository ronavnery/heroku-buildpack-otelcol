#!/usr/bin/env bash

export PATH="$PATH:$HOME/bin"

# Explicitly check if APP_OTELCOL is set and assign a default if not
if [ -z "${APP_OTELCOL}" ]; then
  APP_OTELCOL="/app/otelcol"
fi

PRERUN_SCRIPT="$APP_OTELCOL/prerun.sh"
if [ -e "$PRERUN_SCRIPT" ]; then
  source "$PRERUN_SCRIPT"
fi

if [ -n "$DISABLE_OTELCOL" ]; then
  echo "The OpenTelemetry Collector agent has been disabled. Unset the $DISABLE_OTELCOL or set missing environment variables."
else
  bash -c "otelcol --config $APP_OTELCOL/config.yaml 2>&1 &"
fi
