#!/usr/bin/env bash

usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
temp=$(sensors | grep 'Tctl:' | awk '{print int($2)}')

echo "{\"text\":\"$usage\", \"tooltip\":\"CPU: ${usage}%\\nTemp: ${temp}°C\"}"
