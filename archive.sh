#!/bin/bash
set -euo pipefail
set -vx

search="$1"
query="$(echo "$search" | ruby -rcgi -ne 'puts CGI.escape($_.chomp)')"

youtube-dl -U
youtube-dl -f 38/37/22/18 -o "%(title)s.%(ext)s" "https://www.youtube.com/results?search_query=%22${query}%22&sp=EgIQAQ%253D%253D"
