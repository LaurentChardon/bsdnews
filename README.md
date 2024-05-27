# bsdnews

BSD News Reader Script

## Description

`bsdnews` is a command-line utility that fetches and displays news from various BSD operating system feeds (FreeBSD, NetBSD and OpenBSD by default). It uses Python and supports various features such as displaying only new content, color output and output filtering. It can be used with any RSS feed besides the default

## Features

- Fetch news from FreeBSD, OpenBSD, and NetBSD RSS feeds.
- Display news with color output (optional).
- Filter HTML anchors to display only text.
- Display news from specific feeds independently (`--freebsd`, `--openbsd`, `--netbsd`).
- Combine options to display multiple feeds.
- Truncate summaries to the first line.
- Supports silent mode to suppress all messages when there is no news.

## Dependencies

- Python 3.6+
- `requests`
- `feedparser`
- `beautifulsoup4`
- `blessed`
- `less`
