/*
 * user.js
 *
 */

// Disable notifications.
user_pref("dom.webnotifications.enabled", false);

// Disable analytics async HTTP requests.
user_pref("beacon.enabled", false);

// Disable speech synthesis.
user_pref("media.webspeech.synth.enabled", false);

// Disable domain guessing when entering invalid URLs.
user_pref("browser.fixup.alternate.enabled", false);

// Disable Pocket.
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
