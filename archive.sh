#!/bin/bash
set -euo pipefail
set -vx

search="$1"
query="$(echo "$search" | ruby -rcgi -ne 'puts CGI.escape($_.chomp)')"


youtube-dl -U

youtube-dl -f 38/37/22/18 -o "%(title)s.%(ext)s" "https://www.youtube.com/results?search_query=%22${query}%22&sp=EgIQAQ%253D%253D"

curl -s "https://vimeo.com/search?q=%22${query}%22" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15' | ruby -ne 'puts $_.scan(/vimeo\.config \|\| {}\), (.+)\);/)' | jq -r '.api.initial_json.data[].clip.link' | xargs -I{} youtube-dl {}
