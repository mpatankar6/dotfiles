#!/usr/bin/env bash

on_error() {
  echo '{"text":"⚠️","tooltip":"Failed to fetch weather data."}'
  exit 0
}
trap on_error ERR
set -o pipefail

for i in $(seq 5); do
  ping -c1 -W2 1.1.1.1 &>/dev/null && break || sleep 2
done

location_data=$(curl -s 'https://ipinfo.io/json')
coords=$(echo "$location_data" \
  | jq -r '.loc | split(",") | "latitude=\(.[0])&longitude=\(.[1])"')

forecast_url=$(printf '%s' \
  "https://api.open-meteo.com/v1/forecast?$coords" \
  "&current=temperature_2m,apparent_temperature,weather_code,is_day" \
  "&daily=weather_code,temperature_2m_max,temperature_2m_min" \
  ",precipitation_probability_max,sunrise,sunset" \
  "&temperature_unit=fahrenheit&timezone=auto&forecast_days=7")
weather_data=$(curl -s "$forecast_url")

jq -nc \
  --arg last_checked "Last Checked: $(date '+%I:%M %p')" \
  --argjson location "$location_data" \
  --argjson weather "$weather_data" \
  '
  # This function was written by AI, it may be off.
  # Table can be found at https://open-meteo.com/en/docs#weathervariables.
  def weather_emoji(is_day):
    tostring |
    ({ "0":  "☀️", "1":  "☀️",
       "2":  "⛅", "3":  "☁️",
       "45": "☁️", "48": "☁️",
       "51": "🌦️", "53": "🌦️", "55": "🌦️",
       "56": "🌦️", "57": "🌦️",
       "61": "🌧️", "63": "🌧️", "65": "🌧️",
       "66": "🌧️", "67": "🌧️",
       "71": "❄️",  "73": "❄️",  "75": "❄️",  "77": "❄️",
       "80": "🌧️", "81": "🌧️", "82": "🌧️",
       "85": "❄️",  "86": "❄️",
       "95": "⛈️", "96": "⛈️", "99": "⛈️"
     } + (if is_day == 0 then
       {"0": "🌙", "1": "🌙", "2": "☁️",
        "51": "🌧️", "53": "🌧️", "55": "🌧️",
        "56": "🌧️", "57": "🌧️"}
     else {} end))[.] // "❓";

  def precipitation(chance):
    if . == "🌧️" or . == "🌦️" or . == "⛈️" or . == "❄️"
    then " (\(chance)%)"
    else ""
    end;

  ($weather.current.temperature_2m | round | tostring) as $temp |
  ($weather.current.apparent_temperature | round | tostring) as $feels_like |
  ($weather.daily.temperature_2m_max[0] | round | tostring) as $high |
  ($weather.daily.temperature_2m_min[0] | round | tostring) as $low |

  "\($weather.current.weather_code | weather_emoji($weather.current.is_day)) \($temp)°F" as $text |

  "\($text) (feels like \($feels_like)°F)" +
  "  Low \($low)°F / High \($high)°F"
  as $current_condition |

  ([range(1; 7) | . as $i |
    ($weather.daily.weather_code[$i] | weather_emoji(1)) as $e |
    "\($weather.daily.time[$i] | strptime("%Y-%m-%d") | strftime("%A") |
       . + (" " * (9 - length)))" +
    "  Low \($weather.daily.temperature_2m_min[$i] | round)°F" +
    " / High \($weather.daily.temperature_2m_max[$i] | round)°F" +
    "  \($e)\($e | precipitation($weather.daily.precipitation_probability_max[$i]))"
  ] | join("\n")) as $forecast |

  "  \($weather.daily.sunrise[0] | strptime("%Y-%m-%dT%H:%M") | strftime("%I:%M %p"))" +
  "    \($weather.daily.sunset[0] | strptime("%Y-%m-%dT%H:%M") | strftime("%I:%M %p"))"
  as $sun_times |

  {
    text: $text,
    tooltip: "<tt>" + ([$current_condition, $sun_times, "", $forecast, "",
              "\($location.city), \($location.region), \($location.country)",
              $last_checked] | join("\n")) + "</tt>"
  }
'
