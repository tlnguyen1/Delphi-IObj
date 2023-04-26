unit LN.IObj.Old;

interface

uses
  System.Classes, System.SysUtils;

type
  {
    // This class is for compilers before Delphi 2009

    // declare and instantiate variable of type TMyObject
    var myObj := IObj;

    // instantiate
    myObj := TObj.Create(TMyObject.Create);

    // use
    TMyObject(myObj.Obj)
  }

  IObj = Interface(IInterface)
    ['{C71075DF-1BCE-4A7E-935B-643DE4C785D6}']
    function GetObj: TObject;
    property Obj: TObject read GetObj;

  end;

  TObj = class(TInterfacedObject, IObj)
  private
    FObj : TObject;
    function GetObj: TObject;
  public
    constructor Create(Obj: TObject); reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TObj.Create(Obj: TObject);
begin
  inherited Create;

  FObj := Obj;
end;

destructor TObj.Destroy;
begin
  FObj.free;
  inherited;
end;

function TObj.GetObj: TObject;
begin
  Result := FObj;
end;

end.
