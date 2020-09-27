program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  bass in 'bass.pas',
  BufferedStream in 'BufferedStream.pas',
  ID3v1Library in 'ID3v1Library.pas',
  ID3v2Library in 'ID3v2Library.pas',
  uTExtendedX87 in 'uTExtendedX87.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'QUICK n RANDOM';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
