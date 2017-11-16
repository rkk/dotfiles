//
// KEYS
//

var HYPER_KEY = ':ctrl;shift';
var ALT_HYPER_KEY = ':ctrl;shift;alt';


//
// APPLICATIIONS
//

var app = {
  'ide':        'PhpStorm',
  'terminal':   'Terminal',
  'altterminal': 'iTerm2',
  'console':    'Terminal',
  'firefox':    'Firefox',
  'devfirefox': 'FirefoxDeveloperEdition',
  'browser':    'Google Chrome',
  'mail':       'Microsoft Outlook',
  'chat':       'Slack',
  'messages':   'WhatsApp',
  'music':      'Spotify',
  'finder':     'Finder',
  'timer':      'TogglDesktop',
  'calendar':   'Calendar'
}


//
// CONFIGURATION
//

S.configAll({
  'keyboardLayout': 'dvorak',
  'windowHintsShowIcons': true,
  'windowHintsIgnoreHiddenWindows': false,
  'windowsHintsSpread': true,
  'windowHintsFontSize': '130',
  'defaultToCurrentScreen': true
});


//
// BINDINGS
//

// Direct applications.
slate.bind('l' + HYPER_KEY, S.op('focus', {
  'app': app.ide
}));

slate.bind('b' + HYPER_KEY, S.op('focus', {
  'app': app.browser
}));

slate.bind('f' + HYPER_KEY, S.op('focus', {
  'app': app.firefox
}));

slate.bind('g' + HYPER_KEY, S.op('focus', {
  'app': app.mail
}));

slate.bind('t' + HYPER_KEY, S.op('focus', {
  'app': app.terminal
}));

slate.bind('t' + ALT_HYPER_KEY, S.op('focus', {
  'app': app.altterminal
}));

slate.bind('h' + HYPER_KEY, S.op('focus', {
  'app': app.chat
}));

slate.bind('n' + HYPER_KEY, S.op('focus', {
  'app': app.finder
}));

slate.bind('c' + ALT_HYPER_KEY, S.op('focus', {
  'app': app.calendar
}));

slate.bind('s' + ALT_HYPER_KEY, S.op('focus', {
  'app': app.music
}));

slate.bind('f' + ALT_HYPER_KEY, S.op('focus', {
  'app': app.devfirefox
}));

slate.bind('d' + HYPER_KEY, S.op('focus', {
  'app': app.console
}));

slate.bind('m' + HYPER_KEY, S.op('focus', {
  'app': app.messages
}));


// Window manipulation.
slate.bind('1' + HYPER_KEY, S.op('throw', {
  'screen': 0,
  'width' : 'screenSizeX',
  'height' : 'screenSizeY'
}));

slate.bind('2' + HYPER_KEY, S.op('throw', {
  'screen': 1
}));

slate.bind('3' + HYPER_KEY, S.op('throw', {
  'screen': 2
}));

// Alt-tab switcher.
slate.bind('tab:alt', S.op('switch'));


