/* User settings */

/* Disable about:config warning */
user_pref("browser.aboutConfig.showWarning", false);
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
/* Skip What's New page after update */
user_pref("browser.startup.homepage_override.mstone", "ignore");
/* Don't open previously opened windows and tabs */
user_pref("browser.startup.page", 1);
/* Don't warn when too many are tabs opened at same time */
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

/* Privacy and security settings */

/* Disable Normandy telemetry */
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
/* Disable installing and running studies */
user_pref("app.shield.optoutstudies.enabled", false);
/* Ensure content blocking settings are set to strict */
/* Enable enhanced tracking protection in strict mode */
/* Enable browser fingerprinting protection */
user_pref("browser.contentblocking.category", "strict");
/* Disable search and form history */
user_pref("browser.formfill.enable", false);
/* Disable activity stream */
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
/* Disable search suggestions */
user_pref("browser.search.suggest.enabled", false);
/* Prevent remote resources from interacting with Firefox chrome */
user_pref("browser.uitour.enabled", false);
/* Disable location bar suggestions */
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.searches", false);
/* Disable health reports */
user_pref("datareporting.healthreport.uploadEnabled", false);
/* Disable data submission */
user_pref("datareporting.policy.dataSubmissionEnabled", false);
/* Disable form autofill */
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
/* Disable link and DNS prefetching */
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.predictor.enabled", false);
user_pref("network.prefetch-next", false);
/* Disable baseline and convenience website exceptions */
user_pref("privacy.trackingprotection.allow_list.baseline.enabled", false);
user_pref("privacy.trackingprotection.allow_list.convenience.enabled", false);
/* Disable username and password autofill */
user_pref("signon.autofillForms", false);
user_pref("signon.rememberSignons", false);
