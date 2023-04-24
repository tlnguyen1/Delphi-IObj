unit IObjTestMain;

interface

uses
  LN.IObj, System.Types, 
  LocalVars, 
  MyClassLeaked, MyClassStandard, MyClassIObj,
  ObjectAsPropertyLeaked, ObjectAsPropertyStandard, ObjectAsPropertyIObj,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, 
  Vcl.ComCtrls, Vcl.WinXPanels;

type
  TfrmIObjTestMain = class(TForm)
    FlowPanel1: TFlowPanel;
    btnHome: TButton;
    btnLocalVariables: TButton;
    btnMyClass: TButton;
    btnLoopVariables: TButton;
    CardPanel1: TCardPanel;
    CardCode: TCard;
    CardIObj: TCard;
    memoIObj: TMemo;
    pgCode: TPageControl;
    tbCodeLeaked: TTabSheet;
    memoLeaked: TMemo;
    btnLeaked: TButton;
    tbCodeStandard: TTabSheet;
    memoStandardFix: TMemo;
    btnStandardFix: TButton;
    tbCodeIObj: TTabSheet;
    btnIObjFix: TButton;
    memoIObjFix: TMemo;
    CardHome: TCard;
    btnObjectAsProperty: TButton;
    lblLeaked: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnLocalVariablesClick(Sender: TObject);
    procedure btnMyClassClick(Sender: TObject);
    procedure btnIObjClick(Sender: TObject);
    procedure btnLoopVariablesClick(Sender: TObject);
    procedure btnObjectAsPropertyClick(Sender: TObject);
  private
    function getFile(const resourceName: string): string;
    function getCode(src: TStrings; const tag: string): string;

    procedure btnLocalVarsLeakedClick(Sender: TObject);
    procedure btnLocalVarsStandardClick(Sender: TObject);
    procedure btnLocalVarsIObjClick(Sender: TObject);

    procedure btnMyClassLeakedClick(Sender: TObject);
    procedure btnMyClassStandardClick(Sender: TObject);
    procedure btnMyClassIObjClick(Sender: TObject);

    procedure btnLoopVarsLeakedClick(Sender: TObject);
    procedure btnLoopVarsStandardClick(Sender: TObject);
    procedure btnLoopVarsIObjClick(Sender: TObject);

    procedure btnObjectAsPropertyLeakedClick(Sender: TObject);
    procedure btnObjectAsPropertyStandardClick(Sender: TObject);
    procedure btnObjectAsPropertyIObjClick(Sender: TObject);

    procedure loadLocalVars;
    procedure loadMyClass;
    procedure loadLoopVars;
    procedure loadObjectAsProperty;
    procedure loadIObj;
  public
  end;

var
  frmIObjTestMain: TfrmIObjTestMain;

implementation

{$R *.dfm}

{ TfrmIObjTestMain }

procedure TfrmIObjTestMain.btnHomeClick(Sender: TObject);
begin
  CardPanel1.ActiveCard := cardHome;
end;

// LocalVars
procedure TfrmIObjTestMain.btnLocalVarsIObjClick(Sender: TObject);
begin
  TLocalVars.executeIObj;
end;

procedure TfrmIObjTestMain.btnLocalVarsLeakedClick(Sender: TObject);
begin
  try
    TLocalVars.executeLeaked;
  finally
    lblLeaked.Visible := true;
  end;
end;

procedure TfrmIObjTestMain.btnLocalVarsStandardClick(Sender: TObject);
begin
  TLocalVars.executeStandard;
end;

// MyClass
procedure TfrmIObjTestMain.btnMyClassClick(Sender: TObject);
begin
  loadMyClass;
  CardPanel1.ActiveCard := cardCode;
end;

procedure TfrmIObjTestMain.btnMyClassIObjClick(Sender: TObject);
begin
  var myClass := TObj.CreateInstance(MyClassIObj.TMyclass.Create);
  myClass.Obj.execute;
end;

procedure TfrmIObjTestMain.btnMyClassLeakedClick(Sender: TObject);
begin
  try
    var myClass := TObj.CreateInstance(MyClassLeaked.TMyclass.Create);
    myClass.Obj.execute;
  finally
    lblLeaked.Visible := true;
  end;
end;

procedure TfrmIObjTestMain.btnMyClassStandardClick(Sender: TObject);
begin
  var myClass := TObj.CreateInstance(MyClassStandard.TMyclass.Create);
  myClass.Obj.execute;
end;

// LoopVariables
procedure TfrmIObjTestMain.btnLoopVariablesClick(Sender: TObject);
begin
  loadLoopVars;
  CardPanel1.ActiveCard := cardCode;
end;


procedure TfrmIObjTestMain.btnLoopVarsIObjClick(Sender: TObject);
begin
  TLoopVars.executeIObj;
end;

procedure TfrmIObjTestMain.btnLoopVarsLeakedClick(Sender: TObject);
begin
  try
    TLoopVars.executeLeaked;
  finally
    lblLeaked.Visible := true;
  end;
end;

procedure TfrmIObjTestMain.btnLoopVarsStandardClick(Sender: TObject);
begin
  TLoopVars.executeStandard;
end;

// ObjectAsProperty
procedure TfrmIObjTestMain.btnObjectAsPropertyClick(Sender: TObject);
begin
  loadObjectAsProperty;
  CardPanel1.ActiveCard := cardCode;
end;

procedure TfrmIObjTestMain.btnObjectAsPropertyIObjClick(Sender: TObject);
begin
  ObjectAsPropertyIObj.THouse.execute;
end;

procedure TfrmIObjTestMain.btnObjectAsPropertyLeakedClick(Sender: TObject);
begin
  try
    ObjectAsPropertyLeaked.THouse.execute;
  finally
    lblLeaked.Visible := true;
  end;
end;

procedure TfrmIObjTestMain.btnObjectAsPropertyStandardClick(Sender: TObject);
begin
  try
    ObjectAsPropertyStandard.THouse.execute;
  finally
    lblLeaked.Visible := true;
  end;
end;


procedure TfrmIObjTestMain.btnIObjClick(Sender: TObject);
begin
  CardPanel1.ActiveCard := cardIObj;
end;

procedure TfrmIObjTestMain.btnLocalVariablesClick(Sender: TObject);
begin
  loadLocalVars;
  CardPanel1.ActiveCard := cardCode;

end;

procedure TfrmIObjTestMain.FormCreate(Sender: TObject);
begin
  CardPanel1.ActiveCard := cardHome;
  loadIObj;
end;

function TfrmIObjTestMain.getCode(src: TStrings; const tag: string): string;
begin
  var lst := TObj.CreateInstance(TStringList.Create);

  var tagBegin := src.IndexOf(format('//%s-begin', [tag]));
  var tagEnd := src.IndexOf(format('//%s-end', [tag]));

  if (tagBegin > 0) and (tagEnd > tagBegin) then
  begin
    for var i := tagBegin + 1 to tagEnd - 1 do
      lst.Obj.add(src[i]);
  end;

  result := lst.Obj.Text;
end;

function TfrmIObjTestMain.getFile(const resourceName: string): string;
begin
  var ss := TObj.CreateInstance(TStringStream.Create);
  var rs := TObj.CreateInstance(TResourceStream.Create(hInstance, resourceName, RT_RCDATA));
  ss.Obj.LoadFromStream(rs.Obj);
  result := ss.Obj.DataString;
end;


procedure TfrmIObjTestMain.loadIObj;
begin
  memoIObj.Lines.Text := getFile('IObj');
end;

procedure TfrmIObjTestMain.loadLocalVars;
begin
  var lst := TObj.CreateInstance(TStringList.Create);
  lst.Obj.Text := getFile('LocalVars');

  memoLeaked.Lines.Text := getCode(lst.Obj, 'LocalVarsLeaked');
  memoStandardFix.Lines.Text := getCode(lst.Obj, 'LocalVarsStandard');
  memoIObjFix.Lines.Text := getCode(lst.Obj, 'LocalVarsIObj');

  btnLeaked.OnClick := btnLocalVarsLeakedClick;
  btnStandardFix.OnClick := btnLocalVarsStandardClick;
  btnIObjFix.OnClick := btnLocalVarsIObjClick;
end;

procedure TfrmIObjTestMain.loadLoopVars;
begin
  var lst := TObj.CreateInstance(TStringList.Create);
  lst.Obj.Text := getFile('LocalVars');

  memoLeaked.Lines.Text := getCode(lst.Obj, 'LoopVarsLeaked');
  memoStandardFix.Lines.Text := getCode(lst.Obj, 'LoopVarsStandard');
  memoIObjFix.Lines.Text := getCode(lst.Obj, 'LoopVarsIObj');

  btnLeaked.OnClick := btnLoopVarsLeakedClick;
  btnStandardFix.OnClick := btnLoopVarsStandardClick;
  btnIObjFix.OnClick := btnLoopVarsIObjClick;
end;

procedure TfrmIObjTestMain.loadMyClass;
begin
  memoLeaked.Lines.Text := getFile('MyClassLeaked');
  memoStandardFix.Lines.Text := getFile('MyClassStandard');
  memoIObjFix.Lines.Text := getFile('MyClassIObj');

  btnLeaked.OnClick := btnMyClassLeakedClick;
  btnStandardFix.OnClick := btnMyClassStandardClick;
  btnIObjFix.OnClick := btnMyClassIObjClick;
end;

procedure TfrmIObjTestMain.loadObjectAsProperty;
begin
  memoLeaked.Lines.Text := getFile('ObjectAsPropertyLeaked');
  memoStandardFix.Lines.Text := getFile('ObjectAsPropertyStandard');
  memoIObjFix.Lines.Text := getFile('ObjectAsPropertyIObj');

  btnLeaked.OnClick := btnObjectAsPropertyLeakedClick;
  btnStandardFix.OnClick := btnObjectAsPropertyStandardClick;
  btnIObjFix.OnClick := btnObjectAsPropertyIObjClick;
end;

end.
