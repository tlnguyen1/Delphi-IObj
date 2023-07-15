object frmIObjTestMain: TfrmIObjTestMain
  Left = 0
  Top = 0
  Caption = 'IObj Test Main'
  ClientHeight = 584
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 21
  object FlowPanel1: TFlowPanel
    Left = 0
    Top = 0
    Width = 220
    Height = 584
    Align = alLeft
    FlowStyle = fsTopBottomLeftRight
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 583
    object btnHome: TButton
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Home'
      TabOrder = 0
      OnClick = btnHomeClick
    end
    object btnLocalVariables: TButton
      AlignWithMargins = True
      Left = 11
      Top = 71
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 30
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Local Variables'
      TabOrder = 1
      OnClick = btnLocalVariablesClick
    end
    object btnMyClass: TButton
      AlignWithMargins = True
      Left = 11
      Top = 106
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Variables Inside a Class'
      TabOrder = 2
      OnClick = btnMyClassClick
    end
    object btnLoopVariables: TButton
      AlignWithMargins = True
      Left = 11
      Top = 141
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Loop variables'
      TabOrder = 3
      OnClick = btnLoopVariablesClick
    end
    object btnObjectAsProperty: TButton
      AlignWithMargins = True
      Left = 11
      Top = 176
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Object Properties'
      TabOrder = 4
      OnClick = btnObjectAsPropertyClick
    end
    object btnCircularRef: TButton
      AlignWithMargins = True
      Left = 11
      Top = 211
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Circular References'
      TabOrder = 5
      OnClick = btnCircularRefClick
    end
    object cbLeaked: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 291
      Width = 200
      Height = 17
      Margins.Top = 50
      Align = alTop
      Caption = 'Leaked executed'
      TabOrder = 6
    end
    object cbStandardFix: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 321
      Width = 200
      Height = 17
      Margins.Top = 10
      Align = alTop
      Caption = 'Standard Fix executed'
      TabOrder = 7
    end
    object cbIObjFix: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 351
      Width = 200
      Height = 17
      Margins.Top = 10
      Align = alTop
      Caption = 'IObj Fix executed'
      TabOrder = 8
    end
    object cbLineNumbers: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 421
      Width = 200
      Height = 17
      Margins.Top = 50
      Align = alTop
      Caption = 'Show Line Numbers'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = cbLineNumbersClick
    end
  end
  object PageControl1: TPageControl
    Left = 220
    Top = 0
    Width = 561
    Height = 584
    ActivePage = tsCode
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 557
    ExplicitHeight = 583
    object tsHome: TTabSheet
      Caption = 'Home'
      TabVisible = False
      object memoCode: TMemo
        Left = 40
        Top = 33
        Width = 481
        Height = 424
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '// Generic syntax'
          ''
          'uses'
          '    LN.IObj;'
          ''
          '---'
          'var'
          '    myObj : IObj<TMyObj>;'
          '    lst : TStringList; ilst : IObj<TStringList>;'
          'begin'
          '    myObj := TObj.Create(TMyObj.Create);'
          '    myObj.Obj.doSomeThing(2);'
          ''
          '    ilst := TObj.Create(TStringList.Create);'
          '    lst := ilst.Obj;'
          ''
          '    lst.add('#39'hello world'#39');'
          '    ilst.Obj.add('#39'hello world 2'#39');'
          'end;')
        TabOrder = 0
      end
    end
    object tsIObj: TTabSheet
      Caption = 'IObj'
      ImageIndex = 1
      TabVisible = False
      object memoIObj: TMemo
        Left = 0
        Top = 0
        Width = 553
        Height = 574
        Margins.Bottom = 45
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsCode: TTabSheet
      Caption = 'tsCode'
      ImageIndex = 2
      TabVisible = False
      object pgCode: TPageControl
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 543
        Height = 564
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ActivePage = tbCodeStandard
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 539
        ExplicitHeight = 563
        object tbCodeLeaked: TTabSheet
          Caption = 'Leaked'
          DesignSize = (
            535
            528)
          object memoLeaked: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 529
            Height = 480
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object btnLeaked: TButton
            Left = 3
            Top = 493
            Width = 150
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Execute'
            TabOrder = 1
          end
        end
        object tbCodeStandard: TTabSheet
          Caption = 'Standard Fix'
          ImageIndex = 1
          DesignSize = (
            535
            528)
          object memoStandardFix: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 529
            Height = 480
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 0
            ExplicitWidth = 525
            ExplicitHeight = 479
          end
          object btnStandardFix: TButton
            Left = 3
            Top = 493
            Width = 150
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Execute'
            TabOrder = 1
            ExplicitTop = 492
          end
        end
        object tbCodeIObj: TTabSheet
          Caption = 'IObj Fix'
          ImageIndex = 2
          DesignSize = (
            535
            528)
          object btnIObjFix: TButton
            Left = 3
            Top = 493
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
            Width = 529
            Height = 480
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
  end
end
