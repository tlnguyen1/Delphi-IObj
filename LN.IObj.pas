unit LN.IObj;

interface

uses
  System.Classes, System.SysUtils, Generics.Collections;

type
  {
    // declare and instantiate variable of type TMyObject
    var myObj := TObj.CreateInstance(TMyObject.Create..);

    // myObj.Obj refers to the created TMyObject
    myObj.Obj
  }

  TBaseObj<T : class> = class(TComponent)
  private
    FObj: T;
    procedure SetObj(const Value: T);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
  end;

  IObj<T> = Interface(IInterface)
    ['{C71075DF-1BCE-4A7E-935B-643DE4C785D6}']
    function GetObj: T;
    property Obj: T read GetObj;

  end;

  TObj<T: class> = class(TInterfacedObject, IObj<T>)
  private
    FObj : T;
    FBaseObj : TBaseObj<T>;
    function GetObj: T;
  public
    constructor Create(Obj: T); reintroduce;
    destructor Destroy; override;
  end;

  TObj = class
  public
    class function CreateInstance<T:class>(Obj: T) : IObj<T>;
    class function CreateList<T:class>: IObj<TList<T>>;
    class function CreateIList<T:class>: IObj<TList<IObj<T>>>;

    class function ToList<T:class>(src: TList<IObj<T>>) : IObj<TList<T>>; overload;
    class function ToList<T:class>(src: array of T) : IObj<TList<T>>; overload;
    class function ToIList<T:class>(src: TList<T>) : IObj<TList<IObj<T>>>;
  end;

implementation

constructor TObj<T>.Create(Obj: T);
begin
  inherited Create;

  if Obj is TComponent then
  begin
    FBaseObj := TBaseObj<T>.Create(nil);
    FBaseObj.SetObj(Obj);
  end
  else
    FObj := Obj;
end;

destructor TObj<T>.Destroy;
begin
  FBaseObj.Free;
  FObj.free;
  inherited;
end;

function TObj<T>.GetObj: T;
begin
  if assigned(FBaseObj) then
    Result := FBaseObj.FObj
  else
    Result := FObj;
end;

{ TBaseObj<T> }

destructor TBaseObj<T>.Destroy;
begin
  FObj.free;
  inherited;
end;

procedure TBaseObj<T>.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if assigned(AComponent) and (Operation = TOperation.opRemove) then
    FObj := nil;

  inherited;
end;

procedure TBaseObj<T>.SetObj(const Value: T);
begin
  FObj := Value;

  if FObj is TComponent then
    TComponent(FObj).FreeNotification(self);
end;

{ TObj }
class function TObj.CreateInstance<T>(Obj: T): IObj<T>;
begin
  result := TObj<T>.Create(Obj);
end;

class function TObj.ToList<T>(src: TList<IObj<T>>): IObj<TList<T>>;
begin
  result := TObj.CreateList<T>;

  for var item in src do
    result.Obj.Add(item.Obj);
end;

class function TObj.ToList<T>(src: array of T): IObj<TList<T>>;
begin
  result := TObj.CreateList<T>;

  for var item in src do
    result.Obj.Add(item);
end;

class function TObj.ToIList<T>(src: TList<T>): IObj<TList<IObj<T>>>;
begin
  result := TObj.CreateIList<T>;

  for var item in src do
    result.Obj.Add(TObj.CreateInstance(item));
end;

class function TObj.CreateIList<T>: IObj<TList<IObj<T>>>;
begin
  result := TObj<TList<IObj<T>>>.Create(TList<IObj<T>>.Create);
end;

class function TObj.CreateList<T>: IObj<TList<T>>;
begin
  result := TObj<TList<T>>.Create(TList<T>.Create);
end;

end.
