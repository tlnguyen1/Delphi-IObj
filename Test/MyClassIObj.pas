unit MyClassIObj;

interface
uses
  LN.IObj, System.Classes, System.SysUtils;

type
  TMyclass = class
  private
    flst: IObj<TStringList>;
    // declare variable using IObj<>
  public
    constructor Create;
    procedure execute;
  end;
implementation

constructor TMyclass.Create;
begin
  flst := TObj.CreateInstance(TStringList.Create);
  // use TObj.CreateInstance() to wrap the instantiated object
end;

procedure TMyclass.execute;
begin
  flst.Obj.Add('line1');
  flst.Obj.Add('line2');

end;

end.
