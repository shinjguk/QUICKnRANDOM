object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = []
  Caption = 'QUICK n RANDOM'
  ClientHeight = 436
  ClientWidth = 684
  Color = clWhite
  Constraints.MinHeight = 250
  Constraints.MinWidth = 700
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    684
    436)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 10
    Top = 300
    Width = 27
    Height = 15
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'TITLE'
  end
  object Label2: TLabel
    Left = 10
    Top = 326
    Width = 37
    Height = 15
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'ARTIST'
  end
  object Label3: TLabel
    Left = 10
    Top = 352
    Width = 40
    Height = 15
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'ALBUM'
  end
  object Label4: TLabel
    Left = 445
    Top = 352
    Width = 43
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = 'BITRATE'
  end
  object Label6: TLabel
    Left = 497
    Top = 352
    Width = 32
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = '0kbps'
  end
  object ListBox1: TListBox
    Left = 5
    Top = 0
    Width = 674
    Height = 290
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = True
    ImeMode = imDisable
    ItemHeight = 15
    ParentDoubleBuffered = False
    TabOrder = 6
    OnClick = ListBox1Click
  end
  object Edit1: TEdit
    Left = 60
    Top = 297
    Width = 490
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 60
    Top = 323
    Width = 490
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    TabOrder = 4
  end
  object Edit3: TEdit
    Left = 60
    Top = 349
    Width = 375
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    TabOrder = 5
  end
  object Button1: TButton
    Left = 555
    Top = 296
    Width = 120
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'NEXT'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 555
    Top = 331
    Width = 120
    Height = 33
    Hint = 
      'save left tags, remove the other ones and change upper cases to ' +
      'lower ones'
    Anchors = [akRight, akBottom]
    Caption = 'SAVE TAGS'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 555
    Top = 366
    Width = 120
    Height = 33
    Hint = 'change non-mp3 or larger bitrate to mp3 192kbps'
    Anchors = [akRight, akBottom]
    Caption = 'CHANGE BITRATE'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = Button4Click
  end
  object ComboBox1: TComboBox
    Left = 10
    Top = 375
    Width = 540
    Height = 23
    Hint = 'error log'
    Style = csDropDownList
    Anchors = [akLeft, akRight, akBottom]
    DoubleBuffered = False
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    TabStop = False
  end
  object LinkLabel1: TLinkLabel
    Left = 10
    Top = 410
    Width = 581
    Height = 19
    Anchors = [akLeft, akRight, akBottom]
    Caption = 
      'Icon made by Freepik from <a href="https://www.flaticon.com">www' +
      '.flaticon.com</a>, <a href="http://www.un4seen.com">BASS</a>, <a' +
      ' href="https://lame.sourceforge.io/">LAME</a> for non-commercial' +
      ' use. '#169' 2020 SHIN Jaeguk'
    TabOrder = 8
    OnLinkClick = LinkLabel1LinkClick
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 336
    Top = 223
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 346
    Top = 233
  end
end
