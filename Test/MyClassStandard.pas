unit MyClassStandard;

interface
uses
  System.Classes, System.SysUtils;

type
  TMyclass = class
  private
    flst: TStringList;
  public
    constructor Create;
    procedure execute;
    destructor Destroy; override;
  end;
implementation

constructor TMyclass.Create;
begin
  flst := TStringList.Create;
end;

destructor TMyclass.Destroy;
begin
  flst.Free;
  // flst.free must be called in the destructor of the class

  inherited;
end;

procedure TMyclass.execute;
begin
  flst.Add('line1');
  flst.Add('line2');

end;

end.
