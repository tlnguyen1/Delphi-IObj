unit LN.IObj;

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

  IObj = Interface(IInterface)
  ['{E60D7897-F083-411B-990D-C87523A80E41}']
    function GetObj : TObject;
    property Obj: TObject read GetObj;
  End;

  // Don't use this class directly .. use TObj instead
  TObjBase = class(TInterfacedObject, IObj)
  private
    FObj : TObject;
    function GetObj : TObject;
  public
    property Obj : TObject read GetObj;
    destructor Destroy; override;
    constructor Create(Obj : TObject);
  end;

  {$IF CompilerVersion >= 20}
  IObj<T> = Interface(IInterface)
    ['{C71075DF-1BCE-4A7E-935B-643DE4C785D6}']
    function GetObj: T;
    property Obj: T read GetObj;
  end;

  TObj<T: class> = class(TObjBase, IObj<T>)
  private
    function GetObj: T;
  end;

  {$ENDIF}

  TObj = class
  public
    {$IF (CompilerVersion < 20) or defined(UseBaseObj) }
    class function Create(Obj: TObject) : IObj; overload;
    {$ENDIF}

    {$IF CompilerVersion >= 20}
    class function Create<T:class>(Obj: T) : IObj<T>; overload;

    {$ENDIF}
  end;

implementation

// TObjBase
destructor TObjBase.Destroy;
begin
  FObj.free;
  inherited;
end;

function TObjBase.GetObj: TObject;
begin
  result := FObj;
end;

constructor TObjBase.Create(Obj: TObject);
begin
  inherited Create;
  FObj := Obj;
end;


{$IF CompilerVersion >= 20}

{ TObj<T> }
function TObj<T>.GetObj: T;
begin
  Result := T(inherited GetObj);
end;

{ TObj }
class function TObj.Create<T>(Obj: T): IObj<T>;
begin
  result := TObj<T>.Create(Obj);
end;

{$IFEND}

{$IF (CompilerVersion < 20) or defined(UseBaseObj)}

{ TObj }

class function TObj.Create(Obj: TObject): IObj;
begin
  result := TObjBase.Create(Obj);
end;

{$ENDIF}

end.
