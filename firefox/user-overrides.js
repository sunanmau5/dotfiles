/**
 * Arkenfox user-overrides.js
 * Store this file in your dotfiles!
 *
 * After copying to a new machine:
 *   1. Download arkenfox: curl -LO https://raw.githubusercontent.com/arkenfox/user.js/master/user.js
 *   2. Download updater: curl -LO https://raw.githubusercontent.com/arkenfox/user.js/master/updater.sh
 *   3. Copy this file to your Firefox profile
 *   4. Run: ./updater.sh
 */

/* =============================================================================
 * USER INTERFACE SETTINGS (unique, not in arkenfox)
 * ============================================================================= */

/* Disable onboarding startup page */
user_pref("browser.aboutwelcome.enabled", false);
/* Ctrl+Tab cycles through the recently used tab */
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);
/* Disable sponsored weather on new tab page */
user_pref("browser.newtabpage.activity-stream.system.showWeather", false);
/* Disable More from Mozilla tab in settings */
user_pref("browser.preferences.moreFromMozilla", false);
/* Disable Firefox Focus promo when private browsing */
user_pref("browser.promo.focus.enabled", false);
/* Check that Firefox is the default browser */
user_pref("browser.shell.checkDefaultBrowser", true);
/* Don't warn when too many tabs are opened at same time */
user_pref("browser.tabs.warnOnOpen", false);
/* Don't show an image preview when you hover on a tab */
user_pref("browser.tabs.hoverPreview.showThumbnails", false);
/* Hide bookmark toolbar */
user_pref("browser.toolbars.bookmarks.visibility", "never");
/* Disable VPN sponsor when private browsing */
user_pref("browser.vpn_promo.enabled", false);
/* Disable smart tab grouping feature that automatically organizes tabs */
user_pref("browser.tabs.groups.smart.userEnabled", false);
/* Disable automatic translation popup when visiting foreign language pages */
user_pref("browser.translations.automaticallyPopup", false);
/* Disable warning dialog when using Ctrl+Q/Cmd+Q quit shortcut */
user_pref("browser.warnOnQuitShortcut", false);
/* Dark blue theme */
user_pref("extensions.activeThemeID", "activist-bold-colorway@mozilla.org");
/* Highlight items when finding in page */
user_pref("findbar.highlightAll", true);
/* Enable vertical tabs in the sidebar instead of horizontal tabs at the top */
user_pref("sidebar.verticalTabs", true);
/* Dismiss the promo tooltip about dragging tabs to pin them in vertical tabs */
user_pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true);
/* Hide sidebar */
user_pref("sidebar.visibility", "hide-sidebar");

/* =============================================================================
 * OVERRIDES (changing arkenfox defaults)
 * ============================================================================= */

/* Override: open home page on new tab */
user_pref("browser.newtabpage.enabled", true);

/* Override: open home page on startup instead of blank (arkenfox: 0) */
user_pref("browser.startup.page", 1);
user_pref("browser.startup.homepage", "about:home");

/* Override: disable tab-to-search (commented out in arkenfox) */
user_pref("browser.urlbar.suggest.engines", false);

/* Override: disable form autofill (commented out in arkenfox) */
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

/* Override: disable Firefox password manager (commented out in arkenfox) */
user_pref("signon.rememberSignons", false);

/* =============================================================================
 * ADDITIONAL PRIVACY (unique, not in arkenfox)
 * ============================================================================= */

/* Disable top stories on new tab page */
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
/* Disable search bar on new tab page */
user_pref("browser.newtabpage.activity-stream.showSearch", false);
/* Disable baseline and convenience tracking protection exceptions */
user_pref("privacy.trackingprotection.allow_list.baseline.enabled", false);
user_pref("privacy.trackingprotection.allow_list.convenience.enabled", false);
