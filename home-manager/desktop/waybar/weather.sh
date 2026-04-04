#!/usr/bin/env bash

# WWO weather code to emoji mapping was written with AI and may be off.
# Reference:
# https://www.mikeafford.com/resources/weather-condition-codes/wwo-code-guide.txt

on_error() {
  echo '{"text":"⚠️","tooltip":"Failed to fetch weather data."}'
  exit 0
}
trap on_error ERR
set -o pipefail

curl -s 'wttr.in/?format=j1' \
  | jq -c --arg last_checked "Last Checked: $(date '+%I:%M %p')" '
  def weather_emoji:
    { "113": "☀️", "116": "⛅",
      "119": "☁️", "122": "☁️", "143": "☁️",
      "176": "🌦️", "179": "❄️", "182": "❄️", "185": "🌦️",
      "200": "⛈️",
      "227": "❄️", "230": "❄️",
      "248": "☁️", "260": "☁️",
      "263": "🌦️", "266": "🌦️", "281": "🌦️", "284": "🌦️",
      "293": "🌧️", "296": "🌧️", "299": "🌧️", "302": "🌧️",
      "305": "🌧️", "308": "🌧️", "311": "🌧️", "314": "🌧️",
      "317": "❄️", "320": "❄️", "323": "❄️", "326": "❄️",
      "329": "❄️", "332": "❄️", "335": "❄️", "338": "❄️",
      "350": "❄️",
      "353": "🌧️", "356": "🌧️", "359": "🌧️",
      "362": "❄️", "365": "❄️", "368": "❄️", "371": "❄️",
      "374": "❄️", "377": "❄️",
      "386": "⛈️", "389": "⛈️", "392": "⛈️", "395": "⛈️"
    }[tostring] // "❓";

  def precipitation(rain_chance; snow_chance):
    if . == "🌧️" or . == "🌦️" or . == "⛈️" then " (\(rain_chance)%)"
    elif . == "❄️" then " (\(snow_chance)%)"
    else ""
    end;

  (.current_condition[0].weatherCode | tonumber | weather_emoji) as $condition_emoji |

  "\($condition_emoji) \(.current_condition[0].temp_F)°F" as $text |

  "\($text) \(.current_condition[0].weatherDesc[0].value)" +
  " (feels like \(.current_condition[0].FeelsLikeF)°F)" +
  "  Low \(.weather[0].mintempF)°F / High \(.weather[0].maxtempF)°F"
  as $current_condition |

  ([.weather[] |
    (.hourly[4].weatherCode | tonumber) as $weather_code |
    ($weather_code | weather_emoji) as $day_emoji |
    ([.hourly[].chanceofrain | tonumber] | max) as $rain_chance |
    ([.hourly[].chanceofsnow | tonumber] | max) as $snow_chance |
    "\(.date | strptime("%Y-%m-%d") | strftime("%A"))" +
    "  Low \(.mintempF)°F / High \(.maxtempF)°F" +
    "  \($day_emoji)\($day_emoji | precipitation($rain_chance; $snow_chance))"
  ] | join("\n")) as $forecast |

  " \(.weather[0].astronomy[0].sunrise)   \(.weather[0].astronomy[0].sunset)"
  as $sun_times |

  "\(.nearest_area[0].areaName[0].value), " +
  "\(.nearest_area[0].region[0].value), " +
  "\(.nearest_area[0].country[0].value)"
  as $location |

  {
    text: $text,
    tooltip: [$current_condition, $sun_times, "", $forecast, $location, $last_checked]
             | join("\n")
  }
'
