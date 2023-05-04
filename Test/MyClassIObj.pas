unit MyClassIObj;

interface
uses
  LN.IObj, System.Classes, System.SysUtils;

type
  TMyclass = class(TComponent)
  private
    flst: IObj<TStringList>;
    function getMessages : TStrings;
  public
    property messages: TStrings read getMessages;

    constructor Create(AOwner: TComponent); override;
    class procedure execute;
  end;
implementation

constructor TMyclass.Create(AOwner: TComponent);
begin
  inherited;
  flst := TObj.Create(TStringList.Create);
end;

class procedure TMyclass.execute;
var
  myClass : IObj<TMyClass>;
begin
  myClass := TObj.Create(TMyClass.Create(nil));

  // some logic
  myClass.Obj.messages.Add('hello world');
end;

function TMyclass.getMessages: TStrings;
begin
  result := flst.Obj;
end;

end.
