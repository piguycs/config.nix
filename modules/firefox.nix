{ ... } :

{
  # Install firefox.
  # TODO: search for the "minimal" config for firefox on my main PC and use that
  programs.firefox = {
    enable = true;

    preferences = {
      # some stupid experiment
      "browser.mini-window.enabled" = false;

      # the new sidebar revamp which I do not want
      "sidebar.revamp" = false;
      "sidebar.verticalTabs" = false;

      # no AI baked into my browser pls
      "browser.ml.chat.enabled" = false;
      "browser.ml.chat.sidebar" = false;
      "browser.ml.chat.shortcuts" = false;
      "browser.ml.chat.menu" = false;
      "browser.ml.chat.page" = false;
    };

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;

      DisableFirefoxAccounts = true;

      # disable the password manager and related functions
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      AutofillCreditCardEnabled = false;
      AutofillAddressEnabled = false;
    };
  };
}
