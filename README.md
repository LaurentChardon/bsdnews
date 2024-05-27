# bsdnews

BSD News Reader Script

## Description

`bsdnews` is a command-line utility that fetches and displays news headlines from various BSD operating system feeds (FreeBSD, NetBSD and OpenBSD by default). It uses Python and supports various features such as displaying only new content, color output and output filtering. It can be used with any RSS feed besides the default
A typical use would be to call `bsdnews` to see updated news since the last time bsdnews was used, `bsdnews --all` to see all news, or including `bsdnews --day` in a login script to see news updates in each new terminal session that is launched in a day.

## Features

- Fetch news from FreeBSD, OpenBSD, and NetBSD RSS feeds.
- Fetch news from any RSS URL.
- Display news with color output (optional).
- Filter HTML formatted news to display as text.
- Display news from specific feeds independently (`--freebsd`, `--openbsd`, `--netbsd`).
- Display multiple feeds.
- Memorize updates for a given day and display the same updates throughout the day (optional).

## Dependencies

- Python 3.6+
- `requests`
- `feedparser`
- `beautifulsoup4`
- `blessed`
- `less`
