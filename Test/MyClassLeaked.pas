unit MyClassLeaked;

interface
uses
  System.Classes, System.SysUtils;

type
  TMyclass = class(TComponent)
  private
    flst: TStringList;
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
  flst := TStringList.Create;
end;

class procedure TMyclass.execute;
var
  myClass : TMyClass;
begin
  myClass := TMyClass.Create(nil);

  // some logic
  myClass.messages.Add('hello world');
end;

function TMyclass.getMessages: TStrings;
begin
  result := flst;
end;

end.
