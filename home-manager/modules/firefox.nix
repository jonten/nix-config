{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta-bin;
    profiles.default.userContent = ''
.tab[notselectedsinceload="true"] {
  font-style: italic;
}

.tab.discarded .tab-title {
    opacity: 0.65; /* default is 0.5 */
}
.tab.discarded .tab-meta-image {
    opacity: 0.6; /* default is 0.45 */
}

#tablist {
  flex-direction: column-reverse;
  display: flex;
  flex: 0 0 auto;
}
.tab.pinned {
  order: 1;
}

#tablist-wrapper.shrinked .tab:not(.pinned) {
  height: 29px !important;
}

body.dark-theme .tab .tab-icon {
  filter: url('data:image/svg+xml;,<svg xmlns="http://www.w3.org/2000/svg"><filter id="s"><feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 -0.2125 -0.7154 -0.0721 1 0" /><feMorphology operator="dilate" radius="1"/><feComponentTransfer><feFuncA type="gamma" offset="0" amplitude="1" exponent="2"/></feComponentTransfer><feGaussianBlur stdDeviation="0.5"/><feComposite in="SourceGraphic" operator="over"/></filter></svg>#s');
}

/* color for icon border + transparent icon bg */
#tablist-wrapper:not(.shrinked) #tablist .tab-icon-wrapper,
#tablist-wrapper:not(.shrinked) #pinnedtablist:not(.compact){
  background-color: silver;
}

/* color for thumbnail border */
#tablist-wrapper:not(.shrinked) #tablist .tab-meta-image.has-thumbnail,
#tablist-wrapper:not(.shrinked) #pinnedtablist:not(.compact) .tab-meta-image.has-thumbnail {
    border: 2px solid silver;
}

/* color for thumbnail bg color */
#tablist-wrapper:not(.shrinked) #tablist .tab-meta-image,
#tablist-wrapper:not(.shrinked) #pinnedtablist:not(.compact) .tab-meta-image  {
  background-color: #38383D;
}

#tablist {
  scrollbar-width: none;
}
#tablist:hover {
  scrollbar-width: auto;
}

#tablist {
  direction: rtl;
}
.tab {
  direction: ltr;
}

#tablist {
  scrollbar-width: thin;
}

/* Fix title gradient */
.tab:hover:not(.pinned) > .tab-title-wrapper {
  mask-image: linear-gradient(to left, transparent 0, black 2em);
}

.tab-loading-burst {
  display: none;
}

#newtab-label {
  display: none;
}
    '';
    profiles.default.userChrome = ''
#main-window:not([customizing]):not([tabsintitlebar="true"]) #TabsToolbar {
  visibility: collapse;
}
#navigator-toolbox {
  margin-top: 1px;
}

#sidebar-box #sidebar-header {
  visibility: collapse;
}

#sidebar-box[sidebarcommand="_0ad88674-2b41-4cfb-99e3-e206c74a0076_-sidebar-action"] #sidebar-header {
  visibility: collapse;
}

#sidebar-header {
  background: #0C0C0D;
  border-bottom: none !important;
}
#sidebar-splitter {
  border-right-color: #0C0C0D !important;
  border-left-color: #0C0C0D !important;
}
#sidebar-switcher-target,
#sidebar-close {
  filter: invert(100%);
}

/* Windows users might also want to consider setting
  * browser.tabs.drawInTitlebar to false in about:config
  */

#TabsToolbar {
  visibility: collapse !important;
}

#navigator-toolbox {
  border-bottom: 0 !important;
}

#sidebar-box {
  display: flex;
  flex-direction: column;
  overflow: hidden;
  width: 34px;
  position: fixed;
  z-index: 1;
  transition: all 0.2s ease;
  border-right: 1px solid #333; /* Adjust to fit your theme */
}

#sidebar-box:hover,
#sidebar-header,
#sidebar {
  width: 20vw !important;
}

#sidebar-splitter {
  display: none;
}

/*
  * Adjust to your settings!
  * You need to subtract the height of the panels above sidebar: nav bar,
  * bookmarks bar, etc. -- whichever is enabled/displayed.
  *
  * You can see which mode (normal, compact or touch) you’re in by going to:
  * Firefox Menu → Customize… (at the bottom of the screen) → Density
  *
  *                | normal | compact | touch
  * Menu bar       |  27px  |   27px  |  27px
  * Tab bar        |  33px  |   29px  |  41px
  * Nav bar        |  40px  |   32px  |  40px
  * Bookmarks bar  |  23px  |   21px  |  27px
  *
  * Example:
  * - tab bar is hidden with CSS above (0px)
  * - menu and bookmarks bar are hidden by default (0px)
  * - that only leaves nav bar = 40px in normal mode (default)
  */
#sidebar-box {
  height: calc(100vh - 53px);
}

#sidebar {
  flex-grow: 1;
}

#sidebar-box:not([hidden]) ~ #appcontent {
  margin-left: 34px;
}

#main-window[inFullscreen][inDOMFullscreen] #appcontent {
  margin-left: 0;
}

#main-window[inFullscreen] #sidebar-box {
  height: 100vh;
}
    '';
  };
}



