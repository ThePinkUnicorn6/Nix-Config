{ config, pkgs, ... }:
{
  programs.vesktop = {
    enable = true;
    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      plugins = {
        AnonymiseFileNames.enabled = true;
        BetterGifPicker.enabled = true;
        CrashHandler.enabled = true;
        FakeNitro.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        FriendsSince.enabled = true;
        ImplicidRelationships.enabled = true;
        MessageLogger.enabled = true;
        petpet.enabled = true;
        Platformindicators.enabled = true;
        SendTimestamps.enabled = true;
        ShowHiddenChannels = {
          enabled = true;
          hideUnreads = false;
        };
        ShowHiddenThings.enabled = true;
        TypingIndicator.enabled = true;
        UserMessagesPronouns.enabled = true;
        VoiceChatDoubleClick.enabled = true;
        WebKeybinds.enabled = true;
        WebScreenShareFixes.enabled = true;
        YoutubeAdblock.enabled = true;
      };
    };
  };
}
