#
# BEHAVIOR
#
# Do not use tabs, open in separate windows.
RKK_TABS_AS_WINDOWS = True


c.content.host_blocking.enabled = True
c.content.private_browsing = False
c.content.javascript.enabled = False
c.auto_save.session = False
c.url.start_pages = ["qute://version"]
c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.remove_finished = 0
c.downloads.position = 'bottom'
c.statusbar.hide = False
c.tabs.favicons.show = 'never'
c.tabs.show = 'switching'
c.url.searchengines = {
	'DEFAULT': 'https://duckduckgo.com/?q={}',
	'g': 'https://google.com/search?q={}',
	'r': 'https://www.reddit.com/r/{}',
	'b': 'https://www.bing.com/search?q={}'
}

c.tabs.tabs_are_windows = RKK_TABS_AS_WINDOWS


#
# APPEARANCE
#

config.source('pale-color.py')


#
# KEYBINDING
#

config.bind("xi", "set content.images false")
config.bind("xI", "set content.images true")
config.bind("xb", "set content.host_blocking.enabled false")
config.bind("xB", "set content.host_blocking.enabled true")
config.bind("xj", "set content.javascript.enabled false")
config.bind("xJ", "set content.javascript.enabled true")
config.bind("xs", "set content.user_stylesheets ['rkk-qutebrowser-userstyle.css']")
config.bind("xS", "set content.user_stylesheets []")
config.bind(",f", 'spawn -d firefox {url}')


if RKK_TABS_AS_WINDOWS:
	config.bind("d", "close")


#
# SITE SPECIFIC BEHAVIOR
#

c.content.host_blocking.lists = [
	'https://www.malwaredomainlist.com/hostslist/hosts.txt',
	'http://someonewhocares.org/hosts/hosts',
	'http://winhelp2002.mvps.org/hosts.zip',
	'http://malwaredomains.lehigh.edu/files/justdomains.zip',
	'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext'
]

javascript_whitelist = [
	"*://localhost/*",
	"*://127.0.0.1/*",
	"*://github.com/*",
	"*://duckduckgo.com/*",
	"*://coven.link/*",
	"*://reddit.com/*",
	"*://imgur.com/*",
	"*://groups.google.com/*",
	"*://*.notion.so/*"
]

for site in javascript_whitelist:
	with config.pattern(site) as p:
		p.content.javascript.enabled = True

