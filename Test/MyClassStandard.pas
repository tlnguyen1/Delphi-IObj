unit MyClassStandard;

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
    destructor Destroy; override;
    class procedure execute;
  end;
implementation

constructor TMyclass.Create(AOwner: TComponent);
begin
  inherited;
  flst := TStringList.Create;
end;

destructor TMyclass.Destroy;
begin
  flst.Free;
  inherited;
end;

class procedure TMyclass.execute;
var
  myClass : TMyClass;
begin
  myClass := TMyClass.Create(nil);

  try
    // some logic
    myClass.messages.Add('hello world');
  finally
    myClass.Free;
  end;
end;

function TMyclass.getMessages: TStrings;
begin
  result := flst;
end;

end.
