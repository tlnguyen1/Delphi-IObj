unit LN.ObjList;

interface
uses
  LN.IObj, Generics.Collections;

type
  TObjList<T:class> = class(TList<IObj<T>>);
  TObjArray<T> = array of IObj<T>;

  TObjList = class
  public
    class function CreateList<T:class>: IObj<TList<T>>;
    class function CreateObjList<T:class>: IObj<TObjList<T>>;

    // IObj<TList<T>>
    class function ToList<T:class>(src: TArray<T>) : IObj<TList<T>>; overload;
    class function ToList<T:class>(src: TObjList<T>) : IObj<TList<T>>; overload;
    class function ToList<T:class>(src: TObjArray<T>) : IObj<TList<T>>; overload;

    // IObj<TObjList<T>>
    class function ToObjList<T:class>(src: TList<T>) : IObj<TObjList<T>>; overload;
    class function ToObjList<T:class>(src: TArray<T>) : IObj<TObjList<T>>; overload;
    class function ToObjList<T:class>(src: TObjArray<T>) : IObj<TObjList<T>>; overload;

    // TArray<T>
    class function ToArray<T:class>(src: TObjArray<T>) : TArray<T>; overload;
    class function ToArray<T:class>(src: TList<T>) : TArray<T>; overload;
    class function ToArray<T:class>(src: TObjList<T>) : TArray<T>; overload;

    // TArray<IObj<T>>
    class function ToObjArray<T:class>(src: TArray<T>) : TObjArray<T>; overload;
    class function ToObjArray<T:class>(src: TList<T>) : TObjArray<T>; overload;
    class function ToObjArray<T:class>(src: TObjList<T>) : TObjArray<T>; overload;

  end;

implementation

{ TObjList }
class function TObjList.ToArray<T>(src: TObjArray<T>): TArray<T>;
var
  item : T;
  i, len : Integer;
begin
  len := length(src);
  setLength(result, len);

  for i := 0 to len-1 do
    result[i] := src[i].Obj;
end;

class function TObjList.CreateList<T>: IObj<TList<T>>;
begin
  result := TObj.Create(TList<T>.Create);
end;

class function TObjList.CreateObjList<T>: IObj<TObjList<T>>;
begin
  result := TObj.Create(TObjList<T>.Create);
end;


class function TObjList.ToList<T>(src: TObjList<T>): IObj<TList<T>>;
var
  item : IObj<T>;
begin
  result := TObjList.CreateList<T>;

  for item in src do
    result.Obj.Add(item.Obj);
end;

class function TObjList.ToList<T>(src: TArray<T>): IObj<TList<T>>;
var
  item : T;
begin
  result := TObjList.CreateList<T>;

  for item in src do
    result.Obj.Add(item);
end;

class function TObjList.ToArray<T>(src: TObjList<T>): TArray<T>;
var
  i, len : Integer;
begin
  len := src.Count;
  setLength(result, len);

  for i := 0 to len-1 do
    result[i] := src[i].Obj;
end;

class function TObjList.ToArray<T>(src: TList<T>): TArray<T>;
var
  i, len : Integer;
begin
  len := src.Count;
  setLength(result, len);

  for i := 0 to len-1 do
    result[i] := src[i];
end;

class function TObjList.ToList<T>(src: TObjArray<T>): IObj<TList<T>>;
var
  item : IObj<T>;
begin
  result := TObjList.CreateList<T>;

  for item in src do
    result.Obj.Add(item.Obj);
end;

class function TObjList.ToObjList<T>(src: TList<T>): IObj<TObjList<T>>;
var
  item : T;
begin
  result := TObjList.CreateObjList<T>;

  for item in src do
    result.Obj.Add(TObj.Create(item));
end;

class function TObjList.ToObjList<T>(src: TArray<T>): IObj<TObjList<T>>;
begin
  result := TObjList.ToObjList<T>(TObjList.ToList<T>(src).Obj);
end;

class function TObjList.ToObjList<T>(src: TObjArray<T>): IObj<TObjList<T>>;
var
  item : IObj<T>;
begin
  result := TObjList.CreateObjList<T>;

  for item in src do
    result.Obj.Add(item);
end;

class function TObjList.ToObjArray<T>(src: TArray<T>): TObjArray<T>;
var
  i, len : Integer;
begin
  len := length(src);
  setLength(result, len);

  for i := 0 to len-1 do
    result[i] := TObj.Create(src[i]);
end;

class function TObjList.ToObjArray<T>(src: TList<T>): TObjArray<T>;
var
  i, len : Integer;
begin
  len := src.Count;
  setLength(result, len);

  for i := 0 to len-1 do
    result[i] := TObj.Create(src[i]);
end;

class function TObjList.ToObjArray<T>(src: TObjList<T>): TObjArray<T>;
var
  i, len : Integer;
begin
  len := src.Count;
  setLength(result, len);

  for i := 0 to len-1 do
    result[i] := src[i];
end;

end.
