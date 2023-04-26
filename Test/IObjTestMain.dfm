object frmIObjTestMain: TfrmIObjTestMain
  Left = 0
  Top = 0
  Caption = 'IObj Test Main'
  ClientHeight = 585
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object FlowPanel1: TFlowPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 585
    Align = alLeft
    FlowStyle = fsTopBottomLeftRight
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 584
    object btnHome: TButton
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 165
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Home'
      TabOrder = 0
      OnClick = btnHomeClick
    end
    object btnIObj: TButton
      AlignWithMargins = True
      Left = 11
      Top = 41
      Width = 165
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'IObj'
      TabOrder = 1
      OnClick = btnIObjClick
    end
    object btnLocalVariables: TButton
      AlignWithMargins = True
      Left = 11
      Top = 76
      Width = 165
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Local Variables'
      TabOrder = 2
      OnClick = btnLocalVariablesClick
    end
    object btnMyClass: TButton
      AlignWithMargins = True
      Left = 11
      Top = 111
      Width = 165
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Variables Inside a Class'
      TabOrder = 3
      OnClick = btnMyClassClick
    end
    object btnLoopVariables: TButton
      AlignWithMargins = True
      Left = 11
      Top = 146
      Width = 165
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Loop variables'
      TabOrder = 4
      OnClick = btnLoopVariablesClick
    end
    object btnObjectAsProperty: TButton
      AlignWithMargins = True
      Left = 11
      Top = 181
      Width = 165
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Object Properties'
      TabOrder = 5
      OnClick = btnObjectAsPropertyClick
    end
    object cbLeaked: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 241
      Width = 141
      Height = 17
      Margins.Top = 30
      Align = alTop
      Caption = 'Leaked executed'
      TabOrder = 6
    end
    object cbStandardFix: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 271
      Width = 165
      Height = 17
      Margins.Top = 10
      Align = alTop
      Caption = 'Standard Fix executed'
      TabOrder = 7
    end
    object cbIObjFix: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 301
      Width = 141
      Height = 17
      Margins.Top = 10
      Align = alTop
      Caption = 'IObj Fix executed'
      TabOrder = 8
    end
  end
  object CardPanel1: TCardPanel
    Left = 185
    Top = 0
    Width = 600
    Height = 585
    Align = alClient
    ActiveCard = CardCode
    Caption = 'CardPanel1'
    TabOrder = 1
    ExplicitWidth = 596
    ExplicitHeight = 584
    object CardCode: TCard
      Left = 1
      Top = 1
      Width = 598
      Height = 583
      CardIndex = 0
      TabOrder = 0
      ExplicitWidth = 594
      ExplicitHeight = 582
      object pgCode: TPageControl
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 588
        Height = 573
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ActivePage = tbCodeLeaked
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 584
        ExplicitHeight = 572
        object tbCodeLeaked: TTabSheet
          Caption = 'Leaked'
          DesignSize = (
            580
            543)
          object memoLeaked: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 574
            Height = 495
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 0
            ExplicitWidth = 570
            ExplicitHeight = 494
          end
          object btnLeaked: TButton
            Left = 3
            Top = 515
            Width = 150
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Execute'
            TabOrder = 1
            ExplicitTop = 514
          end
        end
        object tbCodeStandard: TTabSheet
          Caption = 'Standard Fix'
          ImageIndex = 1
          DesignSize = (
            580
            543)
          object memoStandardFix: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 574
            Height = 495
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object btnStandardFix: TButton
            Left = 3
            Top = 510
            Width = 150
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Execute'
            TabOrder = 1
          end
        end
        object tbCodeIObj: TTabSheet
          Caption = 'IObj Fix'
          ImageIndex = 2
          DesignSize = (
            580
            543)
          object btnIObjFix: TButton
            Left = 3
            Top = 510
            Width = 150
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Execute'
            TabOrder = 0
          end
          object memoIObjFix: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 574
            Height = 495
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 1
          end
        end
      end
    end
    object CardIObj: TCard
      Left = 1
      Top = 1
      Width = 598
      Height = 583
      Caption = 'CardIObj'
      CardIndex = 1
      TabOrder = 1
      object memoIObj: TMemo
        Left = 0
        Top = 0
        Width = 598
        Height = 583
        Margins.Bottom = 45
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object CardHome: TCard
      Left = 1
      Top = 1
      Width = 598
      Height = 583
      Caption = 'CardHome'
      CardIndex = 2
      TabOrder = 2
      ExplicitLeft = -10
      ExplicitTop = -13
      object Label1: TLabel
        Left = 48
        Top = 24
        Width = 69
        Height = 15
        Caption = 'uses LN.IObj;'
      end
      object Label2: TLabel
        Left = 48
        Top = 95
        Width = 241
        Height = 15
        Caption = 'var myObj := TIObj.Create(TMyObject.create);'
      end
      object Label3: TLabel
        Left = 48
        Top = 120
        Width = 67
        Height = 15
        Caption = 'myObj.Obj...'
      end
      object Label4: TLabel
        Left = 48
        Top = 226
        Width = 225
        Height = 15
        Caption = 'No need for destructor code to free myObj'
      end
      object Label5: TLabel
        Left = 48
        Top = 250
        Width = 223
        Height = 15
        Caption = 'No need for try finally block to free myObj'
      end
    end
  end
end
