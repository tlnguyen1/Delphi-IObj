unit LN.Obj;

interface

uses
  System.Classes, System.SysUtils {$IF CompilerVersion >= 20}, Generics.Collections {$ENDIF};

type
  {
    // declare and instantiate variable of type TMyObject
    var myVar := TObj.Create(TMyObject.Create);

    Note:
      - Delphi support for generics starts from CompilerVersion 20
      - To compile old syntax with new compiler, add conditional define UseBaseObj
  }

  // Descend your objects from this class to inherit isFreed property
  TBObj = class(TObject)
  private
    fIsFreed : boolean;
  public
    property isFreed: boolean read fIsFreed;
    destructor Destroy; override;
  end;

  {$IF CompilerVersion >= 20}
  IObj<T> = Interface(IInterface)
    ['{C71075DF-1BCE-4A7E-935B-643DE4C785D6}']
    function GetObj: T;
    property Obj: T read GetObj;
  end;

  TObj<T: class> = class(TInterfacedObject, IObj<T>)
  private
    FObj : T;
    function GetObj: T;
  public
    destructor Destroy; override;
  end;

  {$ENDIF}

  IObj = Interface(IInterface)
  ['{E60D7897-F083-411B-990D-C87523A80E41}']
    function GetObj : TObject;
    property Obj: TObject read GetObj;
  End;

  TObj = class(TInterfacedObject, IObj)
  private
    FObj : TObject;
    function GetObj : TObject;
  public
    property Obj : TObject read GetObj;

    {$IF (CompilerVersion < 20) or defined(UseBaseObj) }
    class function Create(Obj: TObject) : IObj; overload;
    {$ENDIF}

    {$IF CompilerVersion >= 20}
    class function Create<T:class>(Obj: T) : IObj<T>; overload;
    {$ENDIF}

    destructor Destroy; override;
  end;

implementation

function TObj.GetObj: TObject;
begin
  result := FObj;
end;

destructor TObj.Destroy;
begin
  if not assigned(FObj) then
    exit;

  if (not (FObj is TBObj)) or (not TBObj(FObj).isFreed)  then
    FObj.Free;

  inherited;
end;


{$IF CompilerVersion >= 20}

{ TObj<T> }
function TObj<T>.GetObj: T;
begin
  Result := FObj;
end;

destructor TObj<T>.Destroy;
begin
  if not assigned(FObj) then
    exit;

  if (not (FObj is TBObj)) or (not TBObj(FObj).isFreed)  then
    FObj.Free;

  inherited;
end;

{ TObj }
class function TObj.Create<T>(Obj: T): IObj<T>;
var
  resultObj : TObj<T>;
begin
  resultObj := TObj<T>.Create;
  resultObj.FObj := Obj;

  result := resultObj;
end;

{$IFEND}

{$IF (CompilerVersion < 20) or defined(UseBaseObj)}

{ TObj }

class function TObj.Create(Obj: TObject): IObj;
var
  resultObj : TObj;
begin
  resultObj := TObj.Create;
  resultObj.FObj := Obj;

  result := resultObj;
end;

{$ENDIF}

{ TBObj }

destructor TBObj.Destroy;
begin
  FIsFreed := True;
  inherited;
end;

end.
