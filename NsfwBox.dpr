program NsfwBox;

uses
  System.StartUpCopy in 'source\tricks\System.StartUpCopy.pas',
  FMX.Forms,
  System.Hash,
  Unit1 in 'source\Unit1.pas' {Form1},
  NsfwBox.Settings in 'source\NsfwBox.Settings.pas',
  NsfwBox.Interfaces in 'source\NsfwBox.Interfaces.pas',
  NsfwBox.Provider.NsfwXxx in 'source\NsfwBox.Provider.NsfwXxx.pas',
  NsfwBox.Provider.R34JsonApi in 'source\NsfwBox.Provider.R34JsonApi.pas',
  NsfwBox.Provider.R34App in 'source\NsfwBox.Provider.R34App.pas',
  NsfwBox.ContentScraper in 'source\NsfwBox.ContentScraper.pas',
  NsfwBox.Graphics in 'source\NsfwBox.Graphics.pas',
  NsfwBox.Provider.Pseudo in 'source\NsfwBox.Provider.Pseudo.pas',
  NsfwBox.Graphics.Browser in 'source\NsfwBox.Graphics.Browser.pas',
  NsfwBox.Consts in 'source\NsfwBox.Consts.pas',
  NsfwBox.Styling in 'source\NsfwBox.Styling.pas',
  NsfwBox.Graphics.Rectangle in 'source\NsfwBox.Graphics.Rectangle.pas',
  Unit2 in 'source\Unit2.pas',
  NsfwBox.DownloadManager in 'source\NsfwBox.DownloadManager.pas',
  NsfwBox.Bookmarks in 'source\NsfwBox.Bookmarks.pas',
  DbHelper in 'source\DbHelper.pas',
  NsfwBox.Helper in 'source\NsfwBox.Helper.pas',
  NsfwBox.Provider.Bookmarks in 'source\NsfwBox.Provider.Bookmarks.pas',
  NetHttpClient.Downloader in 'source\NetHttpClient.Downloader.pas',
  FMX.Scroller in 'source\FMX.Scroller.pas',
  NsfwBox.FileSystem in 'source\NsfwBox.FileSystem.pas',
  FMX.Color in 'source\FMX.Color.pas',
  SimpleClipboard in 'source\SimpleClipboard.pas',
  NsfwBox.Provider.GivemepornClub in 'source\NsfwBox.Provider.GivemepornClub.pas',
  NsfwBox.Provider.NineHentaiToApi in 'source\NsfwBox.Provider.NineHentaiToApi.pas',
  NsfwBox.UpdateChecker in 'source\NsfwBox.UpdateChecker.pas',
  NsfwBox.MessageForDeveloper in 'source\NsfwBox.MessageForDeveloper.pas',
  {$IFDEF MSWINDOWS}
  NsfwBox.WindowsTitlebar in 'source\NsfwBox.WindowsTitlebar.pas',
  Windows,
  {$ENDIF }
  NsfwBox.Provider.CoomerParty in 'source\NsfwBox.Provider.CoomerParty.pas',
  FMX.ColumnsView in 'source\FMX.ColumnsView.pas',
  NsfwBox.Provider.Randomizer in 'source\NsfwBox.Provider.Randomizer.pas',
  NsfwBox.Provider.motherless in 'source\NsfwBox.Provider.motherless.pas',
  NsfwBox.Tests in 'source\NsfwBox.Tests.pas',
  NsfwBox.Logging in 'source\NsfwBox.Logging.pas',
  NsfwBox.Provider.Fapello in 'source\NsfwBox.Provider.Fapello.pas',
  NsfwBox.Provider.Gelbooru in 'source\NsfwBox.Provider.Gelbooru.pas',
  NsfwBox.Utils in 'source\NsfwBox.Utils.pas',
  NsfwBox.Provider.Rule34xxx in 'source\NsfwBox.Provider.Rule34xxx.pas',
  NsfwBox.Provider.Realbooru in 'source\NsfwBox.Provider.Realbooru.pas',
  NsfwBox.Provider.Rule34us in 'source\NsfwBox.Provider.Rule34us.pas';

{$R *.res}

begin
  {$IFDEF MSWINDOWS}
  var Mutex := CreateMutex(nil, True, PChar('Global\NsfwBox:' + THashMD5.GetHashString(TNBoxPath.GetAppPath)));
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then exit;
  {$ENDIF}
//  GlobalUseSkia := True;
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait, TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
