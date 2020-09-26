program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ID3v2Library in '..\..\..\programming\delphi\id3\ID3v2Library.pas',
  ID3v1Library in '..\..\..\programming\delphi\id3\ID3v1Library.pas',
  BufferedStream in '..\..\..\programming\delphi\id3\BufferedStream.pas',
  bass in '..\..\..\programming\delphi\bass\delphi\bass.pas',
  uTExtendedX87 in '..\..\..\programming\delphi\id3\uTExtendedX87.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'QUICK n RANDOM';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
