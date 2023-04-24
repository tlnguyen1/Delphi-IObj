unit LocalVars;

interface
uses
  LN.IObj, System.Classes, System.SysUtils;

type
  TLocalVars = class
  public
    class procedure executeLeaked;
    class procedure executeStandard;
    class procedure executeIObj;
  end;


  TLoopVars = class
  public
    class procedure executeLeaked;
    class procedure executeStandard;
    class procedure executeIObj;
  end;

implementation

{ TLocalVars }

//LocalVarsLeaked-begin
class procedure TLocalVars.executeLeaked;
var
  lst : TStringList;
begin
  lst := TStringList.Create;
  // do some logic with lst

  raise Exception.Create('Some error');
  // Some logic exception causing exceptions can happen

  lst.free;
  // if exception occur, lst.free won't be executed.
end;
//LocalVarsLeaked-end

//LocalVarsStandard-begin
class procedure TLocalVars.executeStandard;
var
  lst : TStringList;
begin
  lst := TStringList.Create;
  try
    // do some logic with lst

    raise Exception.Create('Some error');
    // Some logic exception causing exceptions can happen

  finally
    lst.free;
    // lst.free will be executed.
  end;
end;
//LocalVarsStandard-end

//LocalVarsIObj-begin
class procedure TLocalVars.executeIObj;
begin
  var lst := TObj.CreateInstance(TStringList.Create);
  // do some logic with lst

  raise Exception.Create('Some error');
  // Some logic exception causing exceptions can happen
end;
//LocalVarsIObj-end


{ TLoopVars }

//LoopVarsIObj-begin
class procedure TLoopVars.executeIObj;
const
  n = 10;
begin
  for var i := 0 to n-1 do
  begin
    var lst := TObj.CreateInstance(TStringList.Create);

    lst.Obj.Add('line1');
    lst.Obj.Add('line2');
    // do some logic
  end;
end;
//LoopVarsIObj-end

//LoopVarsLeaked-begin
class procedure TLoopVars.executeLeaked;
const
  n = 10;
begin
  for var i := 0 to n-1 do
  begin
    var lst := TStringList.Create;

    lst.Add('line1');
    lst.Add('line2');
    // do some logic
  end;
end;
//LoopVarsLeaked-end

//LoopVarsStandard-begin
class procedure TLoopVars.executeStandard;
const
  n = 10;
begin
  for var i := 0 to n-1 do
  begin
    var lst := TStringList.Create;
    try
      lst.Add('line1');
      lst.Add('line2');
      // do some logic
    finally
      lst.Free;
    end;
  end;
end;
//LoopVarsStandard-end

end.
