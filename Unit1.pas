unit Unit1;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.ShlObj, System.Types, System.IOUtils, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage, ID3v2Library, System.StrUtils, Vcl.OleCtrls, ID3v1Library, bass, Winapi.ShellAPI, System.Generics.Collections, System.Math, Winapi.UrlMon, System.Diagnostics;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    LinkLabel1: TLinkLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
  private
    ID3v2Tag: TID3v2Tag;
    Stream1: HSTREAM;
    FileName1: string;
    ElapsingSecond: Integer;
    MemoryStream1: TMemoryStream;
    SongList: TStringList;
    procedure Log(_Message: string);
    procedure SongPlay(_Index: Integer);
    procedure ID3TagRead;
    procedure SongStop;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure onChannelEnd(handle: HSYNC; channel, data: DWORD; user: Pointer); stdcall;
begin
  Form1.SongPlay(Random(Form1.SongList.Count));
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Button1.Enabled then
  begin
    SongStop;
  end
  else
  begin
    Action := caNone;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  _Path: PWideChar;
  _Array: TStringDynArray;
  _Extension: string;
  _FileName: string;
  i: Integer;
begin
  Application.HintHidePause := 20000;

  ID3v2Tag := TID3v2Tag.Create;

  BASS_Init(-1, 44100, 0, Handle, nil);

  SHGetKnownFolderPath(StringToGUID('{4BD8D571-6D19-48D3-BE97-422220080E43}'), 0, 0, _Path);

  _Array := TDirectory.GetFiles(string(_Path));

  SongList := TStringList.Create;

  ListBox1.Items.BeginUpdate;

  for i := 0 to High(_Array) do
  begin
    _Extension := ExtractFileExt(_Array[i]);

    if (CompareText(_Extension, '.mp3') = 0) or (CompareText(_Extension, '.m4a') = 0) or (CompareText(_Extension, '.wma') = 0) then
    begin
      SongList.Add(_Array[i]);

      _FileName := ExtractFileName(_Array[i]);

      ListBox1.Items.Add(Copy(_FileName, 1, length(_FileName) - 4));
    end;
  end;

  ListBox1.Items.EndUpdate;

  SongPlay(Random(SongList.Count));
end;

procedure TForm1.ID3TagRead;
var
  _Email: string;
  _Rating: Byte;
  _Count: Cardinal;
begin
  Edit1.Text := ID3v2Tag.GetUnicodeText('TIT2');
  Edit2.Text := ID3v2Tag.GetUnicodeText('TPE1');
  Edit3.Text := ID3v2Tag.GetUnicodeText('TALB');

  Label6.Caption := IntToStr(ID3v2Tag.BitRate) + 'kbps';

  _Rating := 0;

  ID3v2Tag.GetPopularimeter(ID3v2Tag.FrameExists('POPM'), _Email, _Rating, _Count);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SongStop;

  SongPlay(Random(SongList.Count));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RemoveID3v1TagFromFile(FileName1);
  RemoveID3v2TagFromFile(FileName1);

  ID3v2Tag.LoadFromFile(FileName1);

  ID3v2Tag.SetUnicodeText('TIT2', LowerCase(Edit1.Text));
  ID3v2Tag.SetUnicodeText('TPE1', LowerCase(Edit2.Text));
  ID3v2Tag.SetUnicodeText('TALB', LowerCase(Edit3.Text));

  ID3v2Tag.SaveToFile(FileName1);

  ID3TagRead;

  Button1.SetFocus;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  _Parameter: string;
begin
  if ID3v2Tag.BitRate > 200 then
  begin
    CopyFile(pwidechar(FileName1), pwidechar('temporary.mp3'), False);

    _Parameter := '-b 192 temporary.mp3 "' + FileName1 + '"';

    ShellExecute(0, nil, 'lame.exe', pwidechar(_Parameter), nil, SW_SHOW);

    Button1.Enabled := False;
    Button2.Enabled := False;
    Button4.Enabled := False;

    ListBox1.SetFocus;

    Timer2.Enabled := True;
  end;
end;

procedure TForm1.LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  HlinkNavigateString(nil, pwidechar(Link));
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  SongStop;

  SongPlay(ListBox1.ItemIndex);
end;

procedure TForm1.Log(_Message: string);
begin
  ComboBox1.Items.Add(FormatDateTime('hh:nn:ss', Time) + ' ' + _Message);

  ComboBox1.ItemIndex := ComboBox1.Items.Count - 1;
end;

procedure TForm1.SongPlay(_Index: Integer);
var
  _FileStream: TFileStream;
begin
  FileName1 := SongList[_Index];

  _FileStream := TFileStream.Create(FileName1, fmOpenRead);

  MemoryStream1 := TMemoryStream.Create;

  MemoryStream1.CopyFrom(_FileStream, _FileStream.Size);

  _FileStream.Free;

  Stream1 := BASS_StreamCreateFile(True, MemoryStream1.Memory, 0, MemoryStream1.Size, 0 or BASS_UNICODE);

  if not BASS_ChannelPlay(Stream1, False) then
  begin
    Log(ExtractFileName(FileName1) + ' is not a valid audio file.');
  end;

  ElapsingSecond := 0;

  BASS_ChannelSetSync(Stream1, BASS_SYNC_END, 0, onChannelEnd, Self); // relay play

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';

  Label6.Caption := '';

  ID3v2Tag.LoadFromFile(FileName1);

  ID3TagRead;
end;

procedure TForm1.SongStop;
begin
  BASS_ChannelStop(Stream1);

  MemoryStream1.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(ElapsingSecond);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  ID3v2Tag.LoadFromFile(FileName1);

  if ID3v2Tag.BitRate = 192 then
  begin
    Timer2.Enabled := False;

    Label6.Caption := IntToStr(ID3v2Tag.BitRate) + 'kbps';

    Button1.Enabled := True;
    Button2.Enabled := True;
    Button4.Enabled := True;

    Button1.SetFocus;
  end;
end;

end.
