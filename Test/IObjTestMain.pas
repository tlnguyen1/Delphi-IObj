unit IObjTestMain;

interface

uses
  LN.Obj, System.Types,
  LocalVars,
  MyClassLeaked, MyClassStandard, MyClassIObj,
  ObjectAsPropertyLeaked, ObjectAsPropertyStandard, ObjectAsPropertyIObj, PersonClass,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, 
  Vcl.ComCtrls;

type
  TfrmIObjTestMain = class(TForm)
    FlowPanel1: TFlowPanel;
    btnHome: TButton;
    btnLocalVariables: TButton;
    btnMyClass: TButton;
    btnLoopVariables: TButton;
    btnObjectAsProperty: TButton;
    cbLeaked: TCheckBox;
    cbStandardFix: TCheckBox;
    cbIObjFix: TCheckBox;
    PageControl1: TPageControl;
    tsHome: TTabSheet;
    tsIObj: TTabSheet;
    tsCode: TTabSheet;
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
    cbLineNumbers: TCheckBox;
    memoCode: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnLocalVariablesClick(Sender: TObject);
    procedure btnMyClassClick(Sender: TObject);
    procedure btnIObjClick(Sender: TObject);
    procedure btnLoopVariablesClick(Sender: TObject);
    procedure btnObjectAsPropertyClick(Sender: TObject);
    procedure cbLineNumbersClick(Sender: TObject);
  private
    function getFile(const resourceName: string): string;
    function getCode(src: TStrings; const tag: string): string;
    procedure showCode(const leaked, standard, iobj : string);
    procedure showLineNumbers(memos : Array of TStrings);
    procedure removeLineNumbers(memos : Array of TStrings);

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
  PageControl1.ActivePage := tsHome;
end;

// LocalVars
procedure TfrmIObjTestMain.btnLocalVarsIObjClick(Sender: TObject);
begin
  try
    TLocalVars.executeIObj;
  finally
    cbIObjFix.Checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnLocalVarsLeakedClick(Sender: TObject);
begin
  try
    TLocalVars.executeLeaked;
  finally
    cbLeaked.Checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnLocalVarsStandardClick(Sender: TObject);
begin
  try
    TLocalVars.executeStandard;
  finally
    cbStandardFix.Checked := true;
  end;
end;

// MyClass
procedure TfrmIObjTestMain.btnMyClassClick(Sender: TObject);
begin
  loadMyClass;
  PageControl1.ActivePage := tsCode;
end;

procedure TfrmIObjTestMain.btnMyClassIObjClick(Sender: TObject);
begin
  try
    MyClassIObj.TMyclass.execute;
  finally
    cbIObjFix.checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnMyClassLeakedClick(Sender: TObject);
begin
  try
    MyClassLeaked.TMyclass.execute;
  finally
    cbLeaked.checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnMyClassStandardClick(Sender: TObject);
begin
  try
    MyClassStandard.TMyclass.execute;
  finally
    cbStandardFix.checked := true;
  end;
end;

// LoopVariables
procedure TfrmIObjTestMain.btnLoopVariablesClick(Sender: TObject);
begin
  loadLoopVars;
  PageControl1.ActivePage := tsCode;
end;


procedure TfrmIObjTestMain.btnLoopVarsIObjClick(Sender: TObject);
begin
  try
    TLoopVars.executeIObj;
  finally
    cbIObjFix.checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnLoopVarsLeakedClick(Sender: TObject);
begin
  try
    TLoopVars.executeLeaked;
  finally
    cbLeaked.checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnLoopVarsStandardClick(Sender: TObject);
begin
  try
    TLoopVars.executeStandard;
  finally
    cbStandardFix.checked := true;
  end;
end;

// ObjectAsProperty
procedure TfrmIObjTestMain.btnObjectAsPropertyClick(Sender: TObject);
begin
  loadObjectAsProperty;
  PageControl1.ActivePage := tsCode;
end;

procedure TfrmIObjTestMain.btnObjectAsPropertyIObjClick(Sender: TObject);
begin
  try
    ObjectAsPropertyIObj.THouse.execute(
        procedure (house: ObjectAsPropertyIObj.THouse)
        begin
          showMessage('Property: ' + house.Address + #13#10 +
                      'Owner: ' + TPerson.getNames(house.Owners) + #13#10 +
                      'Residents: ' + TPerson.getNames(house.Residents));
        end
    );
  finally
    cbIObjFix.checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnObjectAsPropertyLeakedClick(Sender: TObject);
begin
  try
    ObjectAsPropertyLeaked.THouse.execute(
        procedure (house: ObjectAsPropertyLeaked.THouse)
        begin
          showMessage('Property: ' + house.Address + #13#10 +
                      'Owner: ' + TPerson.getNames(house.Owners) + #13#10 +
                      'Residents: ' + TPerson.getNames(house.Residents));
        end
    );
  finally
    cbLeaked.checked := true;
  end;
end;

procedure TfrmIObjTestMain.btnObjectAsPropertyStandardClick(Sender: TObject);
begin
  try
    ObjectAsPropertyStandard.THouse.execute(
        procedure (house: ObjectAsPropertyStandard.THouse)
        begin
          showMessage('Property: ' + house.Address + #13#10 +
                      'Owner: ' + TPerson.getNames(house.Owners) + #13#10 +
                      'Residents: ' + TPerson.getNames(house.Residents));
        end
    );
  finally
    cbStandardFix.checked := true;
  end;
end;


procedure TfrmIObjTestMain.cbLineNumbersClick(Sender: TObject);
begin
  if cbLineNumbers.Checked then
    ShowLineNumbers([memoIObj.Lines, memoLeaked.Lines, memoStandardFix.Lines, memoIObjFix.Lines])
  else
    RemoveLineNumbers([memoIObj.Lines, memoLeaked.Lines, memoStandardFix.Lines, memoIObjFix.Lines]);

end;

procedure TfrmIObjTestMain.btnIObjClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsIObj;
end;

procedure TfrmIObjTestMain.btnLocalVariablesClick(Sender: TObject);
begin
  loadLocalVars;
  PageControl1.ActivePage := tsCode;

end;

procedure TfrmIObjTestMain.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := tsHome;
  pgCode.ActivePageIndex := 0;
  loadIObj;
end;

function TfrmIObjTestMain.getCode(src: TStrings; const tag: string): string;
var
  lst : IObj<TStringList>;
  tagBegin : Integer;
  tagEnd : Integer;
  i : Integer;
begin
  lst := TObj.Create(TStringList.Create);

  tagBegin := src.IndexOf(format('//%s-begin', [tag]));
  tagEnd := src.IndexOf(format('//%s-end', [tag]));

  if (tagBegin > 0) and (tagEnd > tagBegin) then
  begin
    for i := tagBegin + 1 to tagEnd - 1 do
      lst.Obj.add(src[i]);
  end;

  result := lst.Obj.Text;
end;

function TfrmIObjTestMain.getFile(const resourceName: string): string;
var
  ss : IObj<TStringStream>;
  rs : IObj<TResourceStream>;

begin
  ss := TObj.Create(TStringStream.Create);
  rs := TObj.Create(TResourceStream.Create(hInstance, resourceName, RT_RCDATA));
  ss.Obj.LoadFromStream(rs.Obj);
  result := ss.Obj.DataString;
end;


procedure TfrmIObjTestMain.loadIObj;
begin
  memoIObj.Lines.Text := getFile('IObj');
  if cbLineNumbers.Checked then
    ShowLineNumbers([memoIObj.Lines]);
end;

procedure TfrmIObjTestMain.loadLocalVars;
var
  lst : IObj<TStringList>;
begin
  lst := TObj.Create(TStringList.Create);
  lst.Obj.Text := getFile('LocalVars');

  showCode(
      getCode(lst.Obj, 'LocalVarsLeaked'),
      getCode(lst.Obj, 'LocalVarsStandard'),
      getCode(lst.Obj, 'LocalVarsIObj')
  );

  btnLeaked.OnClick := btnLocalVarsLeakedClick;
  btnStandardFix.OnClick := btnLocalVarsStandardClick;
  btnIObjFix.OnClick := btnLocalVarsIObjClick;
end;

procedure TfrmIObjTestMain.loadLoopVars;
var
  lst : IObj<TStringList>;
begin
  lst := TObj.Create(TStringList.Create);
  lst.Obj.Text := getFile('LocalVars');

  showCode(
      getCode(lst.Obj, 'LoopVarsLeaked'),
      getCode(lst.Obj, 'LoopVarsStandard'),
      getCode(lst.Obj, 'LoopVarsIObj')
  );

  btnLeaked.OnClick := btnLoopVarsLeakedClick;
  btnStandardFix.OnClick := btnLoopVarsStandardClick;
  btnIObjFix.OnClick := btnLoopVarsIObjClick;
end;

procedure TfrmIObjTestMain.loadMyClass;
begin
  showCode(
      getFile('MyClassLeaked'),
      getFile('MyClassStandard'),
      getFile('MyClassIObj')
  );

  btnLeaked.OnClick := btnMyClassLeakedClick;
  btnStandardFix.OnClick := btnMyClassStandardClick;
  btnIObjFix.OnClick := btnMyClassIObjClick;
end;

procedure TfrmIObjTestMain.loadObjectAsProperty;
begin
  showCode(
      getFile('ObjectAsPropertyLeaked'),
      getFile('ObjectAsPropertyStandard'),
      getFile('ObjectAsPropertyIObj')
  );

  btnLeaked.OnClick := btnObjectAsPropertyLeakedClick;
  btnStandardFix.OnClick := btnObjectAsPropertyStandardClick;
  btnIObjFix.OnClick := btnObjectAsPropertyIObjClick;
end;

procedure TfrmIObjTestMain.removeLineNumbers(memos: array of TStrings);
var
  memo : TStrings;
  i : Integer;
begin
  self.LockDrawing;
  try
    for memo in memos do
    begin
      for i := 0 to memo.Count - 1 do
        memo[i] := StringReplace(memo[i], intToStr(i+1) + #9, '', []);
    end;
  finally
    self.UnlockDrawing;
  end;
end;

procedure TfrmIObjTestMain.showCode(const leaked, standard, iobj: string);
begin
  memoLeaked.Lines.Text := leaked;
  memoStandardFix.Lines.Text := standard;
  memoIObjFix.Lines.Text := iobj;

  if cbLineNumbers.Checked then
    ShowLineNumbers([memoLeaked.Lines, memoStandardFix.Lines, memoIObjFix.Lines]);
end;

procedure TfrmIObjTestMain.showLineNumbers(memos: array of TStrings);
var
  memo : TStrings;
  i : Integer;
begin
  self.LockDrawing;
  try
    for memo in memos do
    begin
      for i := 0 to memo.Count - 1 do
        memo[i] := format('%d'#9'%s', [i+1, memo[i]]);
    end;

  finally
    self.UnlockDrawing;
  end;
end;

end.
