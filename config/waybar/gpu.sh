#!/usr/bin/env bash

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=noheader,nounits)
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=noheader,nounits)

echo "{\"text\":\"$usage\", \"tooltip\":\"GPU: ${usage}%\\nTemp: ${temp}°C\"}"
