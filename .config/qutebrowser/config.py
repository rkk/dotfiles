#
# BEHAVIOR
#

c.content.host_blocking.enabled = True
c.content.private_browsing = True
c.content.javascript.enabled = False
c.auto_save.session = False
c.url.start_pages = ["qute://version"]


#
# APPEARANCE
#

c.colors.statusbar.normal.bg = "#fdf6e3"
c.colors.statusbar.normal.fg = "black"
c.colors.messages.error.fg = c.colors.statusbar.normal.fg
c.colors.messages.error.bg = c.colors.statusbar.normal.bg


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


#
# SITE SPECIFIC BEHAVIOR
#

javascript_whitelist = [
        "*://localhost/*",
        "*://127.0.0.1/*",
        "*://github.com/*",
        "*://duckduckgo.com/*",
        "*://coven.link/*",
        "*://reddit.com/*",
        "*://imgur.com/*"
]

for site in javascript_whitelist:
    with config.pattern(site) as p:
        p.content.javascript.enabled = True

