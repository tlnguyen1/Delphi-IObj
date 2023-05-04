object frmIObjTestMain: TfrmIObjTestMain
  Left = 0
  Top = 0
  Caption = 'IObj Test Main'
  ClientHeight = 582
  ClientWidth = 773
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
  object FlowPanel1: TPanel
    Left = 0
    Top = 0
    Width = 220
    Height = 582
    Align = alLeft
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 581
    object btnHome: TButton
      AlignWithMargins = True
      Left = 11
      Top = 13
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Home'
      TabOrder = 0
      OnClick = btnHomeClick
    end
    object btnLocalVariables: TButton
      AlignWithMargins = True
      Left = 11
      Top = 76
      Width = 200
      Height = 25
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Local Variables'
      TabOrder = 1
      OnClick = btnLocalVariablesClick
    end
    object btnMyClass: TButton
      AlignWithMargins = True
      Left = 11
      Top = 111
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
      Top = 146
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
      Top = 181
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
    object cbLeaked: TCheckBox
      AlignWithMargins = True
      Left = 2
      Top = 259
      Width = 212
      Height = 17
      Margins.Top = 50
      Caption = 'Leaked executed'
      TabOrder = 5
    end
    object cbStandardFix: TCheckBox
      AlignWithMargins = True
      Left = 2
      Top = 289
      Width = 212
      Height = 17
      Margins.Top = 10
      Caption = 'Standard Fix executed'
      TabOrder = 6
    end
    object cbIObjFix: TCheckBox
      AlignWithMargins = True
      Left = 2
      Top = 319
      Width = 212
      Height = 17
      Margins.Top = 10
      Caption = 'IObj Fix executed'
      TabOrder = 7
    end
    object cbLineNumbers: TCheckBox
      AlignWithMargins = True
      Left = 2
      Top = 389
      Width = 212
      Height = 17
      Margins.Top = 50
      Caption = 'Show Line Numbers'
      TabOrder = 8
      OnClick = cbLineNumbersClick
    end
  end
  object PageControl1: TPageControl
    Left = 220
    Top = 0
    Width = 553
    Height = 582
    ActivePage = tsHome
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 549
    ExplicitHeight = 581
    object tsHome: TTabSheet
      Caption = 'Home'
      TabVisible = False
      object memoCode: TMemo
        Left = 40
        Top = 33
        Width = 481
        Height = 400
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '// Non generic syntax'
          ''
          'uses'
          '    LN.IObj;'
          ''
          '---'
          'var'
          '    myObj : TMyObj; imyObj : IObj;'
          '---'
          '    myObj := TMyObj.Create; imyObj := TObj.Create(myObj);'
          ''
          '   // call do doSomething in 2 ways '
          '    myObj.doSomething(1);'
          '    TMyObj(iMyObj).Obj.doSomeThing(2);'
          ''
          ''
          '    // No need to call myObj.free')
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
        Width = 545
        Height = 572
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
        Width = 535
        Height = 562
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ActivePage = tbCodeIObj
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 531
        ExplicitHeight = 561
        object tbCodeLeaked: TTabSheet
          Caption = 'Leaked'
          DesignSize = (
            527
            526)
          object memoLeaked: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 521
            Height = 478
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object btnLeaked: TButton
            Left = 3
            Top = 491
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
            527
            526)
          object memoStandardFix: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 521
            Height = 478
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object btnStandardFix: TButton
            Left = 3
            Top = 491
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
            527
            526)
          object btnIObjFix: TButton
            Left = 3
            Top = 491
            Width = 150
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = 'Execute'
            TabOrder = 0
            ExplicitTop = 490
          end
          object memoIObjFix: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 521
            Height = 478
            Margins.Bottom = 45
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssBoth
            TabOrder = 1
            ExplicitWidth = 517
            ExplicitHeight = 477
          end
        end
      end
    end
  end
end
