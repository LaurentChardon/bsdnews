#!/usr/bin/env python3

import feedparser
import requests
import shutil
import os
import json
from datetime import datetime
from blessed import Terminal
from subprocess import Popen, PIPE
import argparse
from bs4 import BeautifulSoup

DATA_DIR = os.path.expanduser('~/.local/state/bsdnews/')
DATA_FILE = os.path.join(DATA_DIR, 'bsdnews_data.json')

# Default feed URLs
FREEBSD_URL = "https://www.freebsd.org/news/feed.xml"
OPENBSD_URL = "http://undeadly.org/cgi?action=rss"
NETBSD_URL = "https://www.netbsd.org/changes/rss-netbsd.xml"

DEFAULT_URLS = [
    FREEBSD_URL,
    OPENBSD_URL,
    NETBSD_URL
]

def fetch_rss_feed(url):
    response = requests.get(url)
    response.raise_for_status()
    return feedparser.parse(response.content)

def clean_html(summary):
    """Extract text from HTML content."""
    soup = BeautifulSoup(summary, 'html.parser')
    return soup.get_text()

def get_first_line_of_summary(summary):
    cleaned_summary = clean_html(summary)
    return cleaned_summary.split('\n', 1)[0]

def build_buffer(feeds, term, use_color=True, display_all=False, display_day=False):
    buffer = []

    displayed_ids, day_ids = load_displayed_ids(display_all, display_day)
    new_displayed_ids = set()

    for feed in feeds:
        feed_buffer = []
        feed_title = feed.feed.get('title', 'No Title')
        
        for entry in feed.entries:
            entry_id = entry.get('id') or entry.get('link')
            if entry_id not in displayed_ids or display_all:
                new_displayed_ids.add(entry_id)
                if 'title' in entry:
                    title = entry.title
                    feed_buffer.append(term.blue(title) if use_color else title)
                if 'link' in entry:
                    feed_buffer.append(entry.link)
                if 'published' in entry:
                    feed_buffer.append(entry.published)
                if 'summary' in entry:
                    summary = get_first_line_of_summary(entry.summary)
                    feed_buffer.append(summary)
                feed_buffer.append("")
        
        if feed_buffer:
            buffer.append(term.bold(feed_title) if use_color else feed_title)
            buffer.append("")
            buffer.extend(feed_buffer)

    if display_day:
        day_ids.update(new_displayed_ids)
        new_displayed_ids = day_ids

    save_displayed_ids(new_displayed_ids, display_day)
    return buffer

def display_buffer(buffer, term, silent=False):
    if not buffer:
        if not silent:
            print("No news to display.")
        return

    terminal_width = shutil.get_terminal_size().columns
    wrapped_buffer = []
    for line in buffer:
        if line.strip() == "":  # Preserve blank lines
            wrapped_buffer.append("")
        else:
            wrapped_lines = term.wrap(line, width=terminal_width)
            wrapped_buffer.extend(wrapped_lines)
    buffer_string = "\n".join(wrapped_buffer)
    
    with Popen(['less', '-R'], stdin=PIPE) as less_proc:
        less_proc.communicate(input=buffer_string.encode('utf-8'))

def load_displayed_ids(display_all, display_day):
    if not os.path.exists(DATA_FILE):
        return set(), set()
    
    with open(DATA_FILE, 'r') as f:
        data = json.load(f)

    today = datetime.today().date().isoformat()

    if display_all:
        return set(), set()

    if display_day:
        return set(data.get(today, [])), set(data.get(today, []))

    return set(data.get('ids', [])), set()

def save_displayed_ids(new_ids, display_day):
    today = datetime.today().date().isoformat()

    if os.path.exists(DATA_FILE):
        with open(DATA_FILE, 'r') as f:
            data = json.load(f)
    else:
        data = {}

    if display_day:
        data[today] = list(new_ids)
    else:
        data['ids'] = data.get('ids', []) + list(new_ids)
    
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR)

    with open(DATA_FILE, 'w') as f:
        json.dump(data, f)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='BSD News Reader')
    parser.add_argument('-a', '--all', action='store_true', help='Display all news entries')
    parser.add_argument('-d', '--day', action='store_true', help='Display news as if it was the first time today')
    parser.add_argument('-n', '--no-color', action='store_true', help='Disable color output')
    parser.add_argument('-u', '--url', action='append', help='Specify one or more RSS feed URLs', default=DEFAULT_URLS)
    parser.add_argument('-s', '--silent', action='store_true', help='Suppress message when there is no news')
    parser.add_argument('--freebsd', action='store_true', help='Display only FreeBSD news')
    parser.add_argument('--openbsd', action='store_true', help='Display only OpenBSD news')
    parser.add_argument('--netbsd', action='store_true', help='Display only NetBSD news')
    args = parser.parse_args()

    selected_urls = []
    if args.freebsd:
        selected_urls.append(FREEBSD_URL)
    if args.openbsd:
        selected_urls.append(OPENBSD_URL)
    if args.netbsd:
        selected_urls.append(NETBSD_URL)

    if not selected_urls:
        selected_urls = args.url

    feeds = [fetch_rss_feed(url) for url in selected_urls]
    term = Terminal()
    buffer = build_buffer(feeds, term, use_color=not args.no_color, display_all=args.all, display_day=args.day)
    display_buffer(buffer, term, silent=args.silent)
